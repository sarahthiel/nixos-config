{ nixos, pkgs, ... }:

let
  cfg = import ../../secrets.nix;
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
    ../../lib/symlinks/lib.nix
    modules/i3.nix
    modules/alacritty.nix
    modules/firefox.nix
    modules/git.nix
    modules/gpg.nix
    modules/keyring.nix
    modules/pass.nix
    modules/ssh.nix
    modules/thunderbird.nix
    modules/tmux.nix
    modules/vim.nix
    modules/zsh.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sth = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" ]; # Enable ‘sudo’ for the user.
    hashedPassword = cfg.users.sth.hashedPassword;
  };

  environment.homeBinInPath = true;

  home-manager.users.sth = {
   ##programs.bat.enable = true;
   ##programs.fzf.enable = true;
   ##programs.fzf.enableZshIntegration = true;
   ##programs.jq.enable = true;
   ##programs.chromium.enable = true;

   ##services.nextcloud-client.enable = true;
   #home.packages = with pkgs; [timewarrior];
  };

  # persistent folder

  fileSystems."/home/sth/.zoom" = {
    device = "/nix/persistent/home/sth/zoom";
    fsType = "none";
    options = [ "bind" ];
  };
  fileSystems."/home/sth/.vagrant.d" = {
    device = "/nix/persistent/home/sth/vagrant";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/home/sth/.DataGrip2019.3" = {
    device = "/nix/persistent/home/sth/DataGrip";
    fsType = "none";
    options = [ "bind" ];
  };
  fileSystems."/home/sth/.PhpStorm2019.3" = {
    device = "/nix/persistent/home/sth/PhpStorm";
    fsType = "none";
    options = [ "bind" ];
  };
  fileSystems."/home/sth/.gitkraken" = {
    device = "/nix/persistent/home/sth/gitkraken";
    fsType = "none";
    options = [ "bind" ];
  };

}
