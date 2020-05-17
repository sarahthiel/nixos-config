{ config, lib, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 24800 ];

  environment.systemPackages = with pkgs; [
    barrier
  ];
}