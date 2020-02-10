{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";

  home.packages = [
    pkgs.tmux
    pkgs.ncdu
  ];

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    shortcut = "f";
    baseIndex = 1;
    keyMode = "vi";
    historyLimit = 5000;
    customPaneNavigationAndResize = false;
    extraConfig = ''
      # Set reload key to r
      bind r source-file ~/.tmux.conf

      unbind-key f
      bind-key C-f resize-pane -Z

      bind-key C-j display-panes
      set -g display-panes-time 1500

      # Split keeping current working directory
      unbind-key h
      unbind-key -
      bind h split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Remap window navigation and resizing to vim
      bind-key j select-pane -L
      bind-key k select-pane -D
      bind-key l select-pane -R
      bind-key i select-pane -U

      bind -r J resize-pane -L 5
      bind -r K resize-pane -D 5
      bind -r L resize-pane -R 5
      bind -r I resize-pane -U 5

      # new windows start on current directory
      unbind-key c
      bind c new-window -c "#{pane_current_path}"

      # Scroll
      unbind-key u
      bind-key u copy-mode

      # Enable mouse control (clickable windows, panes, resizable panes)
      set -g mouse on

      # Do not rename windows after process names if it was fixed manually
      set -g allow-rename off

      # Panes styling
      set -g pane-active-border-style "fg=#ffcc66"

      # Status bar styling
      set -g status-style 'bg=#373b41,fg=white'

      set -g status-interval 5
      set -g status-left-length 90
      set -g status-right-length 60
      set -g status-justify left
      set -g status-left " "
      set -g status-right ""

      setw -g window-status-current-style "dim"
      setw -g window-status-style "bg=green,fg=black,reverse"

      # window status
      setw -g window-status-format "#{bg=white}#{fg=black} #W "
      setw -g window-status-current-format "#{bg=black}#{fg=white} #W "

      # message text
      set-option -g message-style "bg=white,fg=black"

      setw -g mode-style "bg=colour6,fg=colour0"

      # display current session's name in terminal's title
      set-option -g set-titles on
      set-option -g set-titles-string "#{session_name}"

      # hide status bar if there is only one window
      if -F "#{==:#{session_windows},1}" "set -g status off" "set -g status on"
      set-hook -g window-linked 'if -F "#{==:#{session_windows},1}" "set -g status off" "set -g status on"'
      set-hook -g window-unlinked 'if -F "#{==:#{session_windows},1}" "set -g status off" "set -g status on"'
    '';
  };
}
