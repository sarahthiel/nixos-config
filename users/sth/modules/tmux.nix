{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth.programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "a";
    escapeTime = 0;
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -g renumber-windows on
      set-option -g default-shell ${pkgs.zsh}/bin/zsh

      set-option -g set-titles on
      set-option -g set-titles-string "#T - #W"

      bind r source-file ~/.tmux.conf \; display "Config Reloaded!"
      bind N new-window

      bind \\ split-window -h
      bind h split-window -h
      bind - split-window -v
      bind v split-window -v
      bind 0 select-window -t :=10

      bind S setw synchronize-panes

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind > swap-pane -D
      bind < swap-pane -U

      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      setw -g mouse off

      unbind [
      bind Escape copy-mode
      bind Enter copy-mode

      unbind p
      bind p paste-buffer
      bind -Tcopy-mode-vi 'v' send -X begin-selection
      bind -Tcopy-mode-vi 'y' send -X copy-pipe-and-cancel "tmux save-buffer - | pbcopy"

      bind-key -n S-Up set-option -g status
      bind-key -n S-Down set-option -g status


      set -g status-left-length 32
      set -g status-right-length 150

      set-option -g status-fg "default"
      set-option -g status-bg "default"
      set-option -g status-style "none"

      # default window title colors
      set-window-option -g window-status-style "fg=default,bg=default,none"
      set -g window-status-format " #I #W "

      # active window title colors
      set-window-option -g window-status-current-style "fg=black,bg=blue,bold"
      set-window-option -g window-status-current-format " #I #W "

      # pane border
      set-option -g pane-border-style "fg=colour8,bg=default"
      set-option -g pane-active-border-style "fg=blue,bg=default"

      set-option -g display-panes-colour "blue"
      set-option -g display-panes-active-colour "blue"

      # message text
      set-option -g message-style "fg=black,bg=yellow,bold"

      # pane number display
      set-option -g display-panes-active-colour "blue"
      set-option -g display-panes-colour "blue"
    '';
  };
}