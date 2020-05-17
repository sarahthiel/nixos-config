{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  imports = [
    ./picom.nix
    ./polybar.nix
    ./dunst.nix
    ./rofi.nix
  ];

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.windowManager.i3.extraSessionCommands = ''
    $HOME/bin/i3util site -m
  '';

  home-manager.users.sth.home.file = {
    "bin/i3util".source = ../dotfiles/bin/i3util;
    ".config/i3/config.base".source = ../dotfiles/i3/config.base;
    ".config/i3/config.home".source = ../dotfiles/i3/config.home;
    ".config/i3/config.game".source = ../dotfiles/i3/config.game;
    ".config/i3/config.mobile".source = ../dotfiles/i3/config.mobile;
    ".config/i3/config.office".source = ../dotfiles/i3/config.office;
  };
}