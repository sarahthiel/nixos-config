{ nixos, pkgs, ... }:

let
  cfg = import ../secrets.nix;
in
{
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sth = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" ]; # Enable ‘sudo’ for the user.
    hashedPassword = cfg.users.sth.hashedPassword;
    shell = pkgs.zsh;
  };
}
