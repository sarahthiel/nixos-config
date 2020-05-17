{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{

  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.libu2f-host pkgs.yubikey-personalization ];

  environment.systemPackages = with pkgs; [
    gnupg
    yubikey-personalization
    yubikey-manager-qt
    pinentry-qt
  ];

  #programs.gnupg.agent.enable = true;
  #programs.gnupg.agent.enableSSHSupport = true;
  #programs.gnupg.agent.pinentryFlavor = "qt";


  fileSystems."/home/sth/.gnupg" = {
    device = "/nix/persistent/home/sth/gnupg";
    fsType = "none";
    options = [ "bind" ];
  };
}