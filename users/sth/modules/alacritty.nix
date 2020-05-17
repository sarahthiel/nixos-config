{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth.programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "full";
      scrolling = {
        history = 10000;
      };

      font = {
        normal = {
              family = "Hack Nerd Font Mono";
              style = "Normal";
        };
        bold = {
              family = "Hack Nerd Font Mono";
              style = "Bold";
        };
        italic = {
              family = "Hack Nerd Font Mono";
              style = "Italic";
        };
        size = 10;

        offset = { x = 0; y = 0; };
        glyph_offset = { x = 0; y = 0; };
        scale_with_dpi = true;
      };
      draw_bold_text_with_bright_colors = true;

      colors = {
        primary = {
          background = "0x2E3440";
          foreground = "0xD8DEE9";
        };

        cursor = {
          text = "0x2E3440";
          cursor = "0xD8DEE9";
        };

        normal = {
          black = "0x3B4252";
          red = "0xBF616A";
          green = "0xA3BE8C";
          yellow = "0xEBCB8B";
          blue = "0x81A1C1";
          magenta = "0xB48EAD";
          cyan = "0x88C0D0";
          white = "0xE5E9F0";
        };

        bright = {
          black = "0x4C566A";
          red = "0xBF616A";
          green = "0xA3BE8C";
          yellow = "0xEBCB8B";
          blue = "0x81A1C1";
          magenta = "0xB48EAD";
          cyan = "0x8FBCBB";
          white = "0xECEFF4";
        };
      };

      visual_bell.duration = 0;
      background_opacity = 1;

      mouse_bindings = [
        { mouse = "Middle"; action = "PasteSelection"; }
      ];
      mouse = {
        double_clic = { threshold = 300; };
        triple_click = { threshold = 300; };
        hide_when_typing = false;
        url = {
          launcher = "xdg-open";
          modifiers = "Control";
        };
      };

      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>";
        save_to_clipboard = false;
      };

      dynamic_title = false;

      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };

      live_config_reload = false;

      shell.program = "${pkgs.zsh}/bin/zsh";

      key_bindings = [
        {key = "V"; mods = "Control|Shift"; action = "Paste";}
        {key = "C"; mods = "Control|Shift"; action = "Copy";}
        {key = "Insert"; mods = "Shift"; action = "PasteSelection";}
        {key = "Key0"; mods = "Control"; action = "ResetFontSize";}
        {key = "Equals"; mods = "Control"; action = "IncreaseFontSize";}
        {key = "Subtract"; mods = "Control"; action = "DecreaseFontSize";}
      ];
    };
  };
}