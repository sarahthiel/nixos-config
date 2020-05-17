# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/luks.nix
      ./modules/defaults.nix
      ./modules/default-tools.nix
      #./modules/home-manager.nix
      # ./modules/zfs.nix
      ./hosts/twentyone/twentyone.nix
    ];

  system.stateVersion = "20.03";
}
