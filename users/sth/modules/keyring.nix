{ nixos, pkgs, ... }:
{
  services.gnome3.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  fileSystems."/home/sth/.local/share/keyrings" = {
    device = "/nix/persistent/home/sth/local/share/keyrings";
    fsType = "none";
    options = [ "bind" ];
  };
}