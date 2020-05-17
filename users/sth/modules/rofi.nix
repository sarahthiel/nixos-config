{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth = {
    home.file.".config/rofi/theme.rasi".source = ../dotfiles/rofi/theme.rasi;
    programs.rofi = {
      enable = true;
      extraConfig = ''
        rofi.theme:           .config/rofi/theme.rasi
        rofi.show-icons:      false
        rofi.modi:            drun,run,window,ssh
        rofi.lines:           7
        rofi.line-padding:    10
        rofi.matching:        fuzzy
        rofi.bw:              0
        rofi.padding:         0
        rofi.separator-style: none
        rofi.hide-scrollbar:  true
        rofi.line-margin:     0
        rofi.font:            Hack Nerd Font Mono 10
      '';
    };
  };
}