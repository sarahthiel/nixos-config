{ config, services, pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      inconsolata
      nerdfonts
      roboto
    ];
  };
}