{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth.services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        geometry = "300x5-30+20";
        indicate_hidden = true;
        shrink = false;
        transparency = 0;
        notification_height = 0;
        separator_height = 1;
        padding = 24;
        horizontal_padding = 24;
        frame_width = 0;
        frame_color = "#aaaaaa";
        separator_color = "auto";
        sort = true;
        idle_threshold = 120;
        font = "Hack Nerd Font 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "center";
        show_age_threshold = 60;
        word_wrap = true;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = false;
        icon_position = false;
        sticky_history = true;
        history_length = 20;
        dmenu = "${pkgs.rofi}/bin/rofi";
        browser = "${pkgs.firefox}/bin/firefox -new-tab";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        startup_notification = false;
        force_xinerama = false;
      };

      experimental.per_monitor_dpi = false;

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+period";
        context = "ctrl+shift+period";
      };

      urgency_low = {
        background = "#3b4252";
        foreground = "#d8dee9";
        timeout = 10;
      };

      urgency_normal = {
        background = "#3b4252";
        foreground = "#d8dee9";
        timeout = 10;
      };

      urgency_critical = {
        background = "#bf616a";
        foreground = "#eceff4";
        frame_color = "#bf616a";
        timeout = 0;
      };
    };
  };
}