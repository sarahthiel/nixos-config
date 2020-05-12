{ config, pkgs, ... }:

{
  imports = [
    ./virtualbox.nix
  ];

  environment.systemPackages = with pkgs; [
    gitkraken
    jetbrains.phpstorm
    jetbrains.datagrip
    jq
    php
    sublime3
    gitAndTools.hub
    #firefox-devedition-bin
  ];
}
