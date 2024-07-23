{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    # custom settings

    extraConfig = ''
      # set-option -sa terminal-overrides ",xterm*:Tc"
      set -g default-terminal "xterm-256color"
      # set-option -g default-terminal "tmux-256color"


      # Change Prefix
      # unbind C-b
      # set-option -g prefix C-Space
      # bind-key C-Space send-prefix

      set -g mouse on

      # Set the base index for windows to 1
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Set the limit for command history
      set-option -g history-limit 5000

      # Bind | to split the window horizontally at the current path
      bind | split-window -hc "#{pane_current_path}"

      # Bind - to split the window vertically at the current path
      bind - split-window -vc "#{pane_current_path}"

      # Bind C-c to save the tmux buffer to the clipboard
      bind C-c run "tmux save-buffer - | xclip -i -sel clip"

      # Bind C-v to paste the clipboard into the tmux buffer
      bind C-v run "tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer"

      # Bind r to reload the tmux configuration and display a message
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      bind -n M-H previous-window
      bind -n M-L next-window

      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"



      #======================================================================================
      #======================================================================================
      # DESIGN TWEAKS
      # set -g status-position bottom
      # set -g status-justify left
      # set -g status-style 'fg=colour1'
      # set -g status-right '%Y-%m-%d %H:%M '
      # set -g status-right-length 50
      # set -g status-left-length 10
      #
      #
      # # don't do anything when a 'bell' rings
      # set -g visual-activity off
      # set -g visual-bell off
      # set -g visual-silence off
      # setw -g monitor-activity off
      # set -g bell-action none
      #
      # # clock mode
      # setw -g clock-mode-colour colour1
      #
      # # copy mode
      # # setw -g mode-style 'fg=colour1 bg=colour18 bold'
      #
      # # pane borders
      # set -g pane-active-border-style 'fg=colour1'
      # set -g pane-border-style 'fg=none'
      #
      # # statusbar
      # # setw -g window-status-current-style 'fg=colour0 bg=colour1 bold'
      # setw -g window-status-current-format ' #I #W #F '
      # setw -g window-status-style 'fg=colour1 dim'
      #
      # setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour1]#F '
      # setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'
      #
      # messages
      # set -g message-style 'fg=colour2 bg=colour0 bold'


      #======================================================================================
      #======================================================================================
      #

      # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'christoomey/vim-tmux-navigator'
      set -g @plugin 'catppuccin/tmux'
      set -g @plugin 'tmux-plugins/tmux-yank'
      set -g @plugin 'tmux-plugins/tmux-resurrect'

      set -g @catppuccin_flavour 'mocha' # or frappe, macchiato, mocha

      #
      # # window default format
      # set -g @catppuccin_window_default_fill "none"
      # set -g @catppuccin_window_default_text "#( echo \#{pane_current_path} | sed \"s|$HOME|~|\" | xargs basename )"
      #
      # # window current format
      # set -g @catppuccin_window_current_fill "all"
      # set -g @catppuccin_window_current_text "#( echo \#{pane_current_path} | sed \"s|$HOME|~|\" | xargs basename )"
      #
      # # status modules list
      # set -g @catppuccin_status_connect_separator "yes"
      #
      # # config for host module
      # # set -g @catppuccin_host_text "#(whoami)@#h"
      #
      # config for date_time module
      set -g @catppuccin_date_time_text "%m-%d %H:%M"

      set -g @catppuccin_window_left_separator "█"
      set -g @catppuccin_window_right_separator "█ "
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_middle_separator "  █"

      # set -g @catppuccin_window_left_separator ""
      # set -g @catppuccin_window_right_separator " "
      # set -g @catppuccin_window_middle_separator "█ "
      # set -g @catppuccin_window_number_position "left"

      set -g @catppuccin_window_status_icon_enable "yes"
      set -g @catppuccin_icon_window_last "󰖰"
      set -g @catppuccin_icon_window_current "󰖯"
      set -g @catppuccin_icon_window_zoom "󰁌"
      set -g @catppuccin_icon_window_mark "󰃀"
      set -g @catppuccin_icon_window_silent "󰂛"
      set -g @catppuccin_icon_window_activity "󰖲"
      set -g @catppuccin_icon_window_bell "󰂞"


      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"

      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"

      # set -g @catppuccin_status_modules_right "directory session date_time"
      set -g @catppuccin_status_modules_right "directory session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_right_separator_inverse "no"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"

      set -g @catppuccin_directory_text "#{pane_current_path}"

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
