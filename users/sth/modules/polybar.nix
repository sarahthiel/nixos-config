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
    home.file.".config/polybar/launch.sh".source = ../dotfiles/polybar/launch.sh;
    services.polybar = {
      enable = true;

      package = pkgs.polybar.override {
        i3GapsSupport = true;

        pulseSupport = true;
        #libpulseaudio = true;

        #wirelesstools = true;
        iwSupport = true;
        nlSupport = false;
      };

      script = ''
        true
        # polybar main &
      '';

      config = {
        "bar/top" = {
          #monitor = null;
          width = "100%";
          height = "28";
          fixed-center = true;
          line-size = 1;
          padding-right = 2;

          background = "#2E3440";
          foreground = "#D8DEE9";
          module-margin-left = 1;
          module-margin-right = 1;

          font-0 = "Hack Nerd Font Mono:pixelsize=10;2";
          font-1 = "Material Icons:size=11;3";

          cursor-click = "pointer";
          tray-position = "right";
          tray-padding = 3;
          tray-maxsize = 13;
          enable-ipc = true;

          scroll-up = "i3wm-wsnext";
          scroll-down = "i3wm-wsprev";

          modules-left = "i3";
          modules-center = "date";
          modules-right = "cpu temperature memory filesystem battery wlan eth volume";
        };

        "module/i3" = {
          type = "internal/i3";
          format = "<label-state> <label-mode>";
          index-sort = true;
          wrapping-scroll = false;
          strip-wsnumbers = true;
          label-focused = "%name%";
          label-focused-foreground = "#81A1C1";
          label-focused-underline= "#81A1C1";
          label-focused-padding = "1";
          label-unfocused = "%name%";
          label-unfocused-padding = "1";
          label-visible = "%name%";
          label-visible-background = "\${self.label-focused-foreground}";
          label-visible-underline = "\${self.label-focused-underline}";
          label-visible-padding = "\${self.label-focused-padding}";
          label-urgent = "%name%";
          label-urgent-background = "#BF616A";
          label-urgent-padding = 1;
        };

        "module/cpu" = {
          type = "internal/cpu";
          format = "<label> <ramp-coreload>";
          label = "CPU %percentage%%";

          ramp-coreload-spacing = "1";
          ramp-coreload-0 = "▁";
          ramp-coreload-1 = "▂";
          ramp-coreload-2 = "▃";
          ramp-coreload-3 = "▄";
          ramp-coreload-4 = "▅";
          ramp-coreload-5 = "▆";
          ramp-coreload-6 = "▇";
          ramp-coreload-7 = "█";
        };

        "module/temperature" = {
          type = "internal/temperature";

          thermal-zone = 0;
          hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
          base-temperature = 20;
          warn-temperature = 60;
          format = "<ramp> <label>";
          format-warn = "<ramp> <label-warn>";
          label = "TEMP %temperature-c%";
          label-warn = "TEMP %temperature-c%";
          label-warn-foreground = "#f00";
          ramp-0 = "A";
          ramp-1 = "B";
          ramp-2 = "C";
          ramp-foreground = "#55";
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 3;
          format = "<label> <ramp-used>";
          label = "RAM %gb_used%/%gb_free%";

          ramp-used-0 = "▁";
          ramp-used-1 = "▂";
          ramp-used-2 = "▃";
          ramp-used-3 = "▄";
          ramp-used-4 = "▅";
          ramp-used-5 = "▆";
          ramp-used-6 = "▇";
          ramp-used-7 = "█";
        };

        "module/filesystem" = {
          type = "internal/fs";
          mount-0 = "/";
          mount-1 = "/nix";
          interval = 60;
          fixed-values = true;
          format-mounted = "<label-mounted>";
          format-unmounted = "<label-unmounted>";
          label-mounted = "%mountpoint%: %percentage_free%% of %total%";
          label-unmounted = "%mountpoint%: not mounted";
          label-unmounted-foreground = "#4C566A";
        };

        "module/battery" = {
          type = "internal/battery";
          time-format = "%H:%M";
          battery = "BAT0";
          adapter = "AC";
          full-at = "100";

          format-charging = "<animation-charging><label-charging>";
          label-charging = "%percentage%";
          format-discharging = "<ramp-capacity><label-discharging>";
          label-discharging = "%percentage%";
          format-full = "<label-full>";
          label-full = "%percentage%";

          format-full-prefix = "";
          ramp-capacity-0 = "";
          ramp-capacity-1 = "";
          ramp-capacity-2 = "";
          ramp-capacity-3 = "";
          ramp-capacity-4 = "";

          ramp-capacity-0-foreground = "#BF616A";
          ramp-capacity-foreground   = "#D8DEE9";
          bar-capacity-width = 10;

          animation-charging-0 = "";
          animation-charging-1 = "";
          animation-charging-2 = "";
          animation-charging-3 = "";
          animation-charging-4 = "";
          animation-charging-framerate = 750;
        };

        "module/volume" = {
          type = "internal/pulseaudio";
          format-volume = "<ramp-volume><label-volume>";
          label-volume = "%percentage%";
          format-muted-prefix = "";
          label-muted = "MUTE";

          ramp-volume-0 = "";
          ramp-volume-1 = "";
          ramp-volume-2 = "";
        };

        "module/date" = {
          type = "internal/date";
          interval = 1;
          label =  "%time%";
          time = " %a %b %d   %I:%M %p";
          time-alt = " %Y-%m-%d   %H:%M:%S";
        };

        "module/eth" = {
          type = "internal/network";
          interface = "enp0s31f6";
          interval = "3.0";
          label-connected = "";
          format-disconnected = "<label-disconnected>";
          label-disconnected = "";
          label-disconnected-foreground = "#4C566A";
        };

        "module/wlan" = {
          type = "internal/network";
          interface = "wlp0s20f3";
          interval = "3.0";

          format-connected = "<label-connected>";
          label-connected = "";
          label-connected-alt = "%essid%";
          format-disconnected = "<label-disconnected>";
          label-disconnected = "";
          label-disconnected-foreground = "#4C566A";
        };

      };
    };
  };
}