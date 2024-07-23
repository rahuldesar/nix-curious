{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      path = "${config.xdg.dataHome}/zsh/history";
      share = false;
      size = 100000;
      save = 100000;
    };

    profileExtra = ''
            setopt appendhistory
            setopt sharehistory
            setopt hist_ignore_space
            setopt hist_ignore_all_dups
            setopt hist_save_no_dups
            setopt hist_find_no_dups



      #     setopt incappendhistory
      #     setopt histfindnodups
      #     setopt histreduceblanks
      #     setopt histverify
      #     setopt correct                                                  # Auto correct mistakes
      #     setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
      #     setopt nocaseglob                                               # Case insensitive globbing
      #     setopt rcexpandparam                                            # Array expension with parameters
      #     #setopt nocheckjobs                                              # Don't warn about running processes when exiting
      #     setopt numericglobsort                                          # Sort filenames numerically when it makes sense
      #     unsetopt nobeep                                                 # Enable beep
      #     setopt appendhistory                                            # Immediately append history instead of overwriting
      #     unsetopt histignorealldups                                      # If a new command is a duplicate, do not remove the older one
      #     setopt interactivecomments
      #     zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
      #     zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"       # Colored completion (different colors for dirs/files/etc)
      #     zstyle ':completion:*' rehash true                              # automatically find new executables in path
      #     # Speed up completions
      #     zstyle ':completion:*' accept-exact '*(N)'
      #     zstyle ':completion:*' use-cache on
      #     mkdir -p "$(dirname ${config.xdg.cacheHome}/zsh/completion-cache)"
      #     zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/completion-cache"
      #     zstyle ':completion:*' menu select
      #     WORDCHARS=''${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = { test = "pwd"; };

    initExtra = ''
              # Set the directory we want to store zinit and plugins
              ZINIT_HOME="$XDG_DATA_HOME:-$HOME/.local/share/zinit/zinit.git"

              # Download Zinit, if it's not there yet
              if [ ! -d "$ZINIT_HOME" ]; then
                 mkdir -p "$(dirname $ZINIT_HOME)"
                 git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
              fi

              # Source/Load zinit
              source "$ZINIT_HOME/zinit.zsh"


      #     # Reload fzf binds after vi mode
      #     zvm_after_init() {
      #       source ${config.programs.fzf.package}/share/fzf/key-bindings.zsh
      #     }
      #     if [ -z $ZSH_RELOADING_SHELL - ]; then
      #     echo $USER@$HOST  $(uname -srm) \
      #         $(sed -n 's/^NAME=//p' /etc/os-release 2>/dev/null || printf "") \
      #         $(sed -n 's/^VERSION=//p' /etc/os-release 2>/dev/null || printf "")
      #     fi
      #     ## Keybindings section
      #     # vi movement keys on home row
      #     bindkey -M vicmd j vi-backward-char
      #     bindkey -M vicmd k vi-down-line-or-history
      #     bindkey -M vicmd l vi-up-line-or-history
      #     bindkey -M vicmd \; vi-forward-char
      #     bindkey -e
      #     bindkey '^[[7~' beginning-of-line                               # Home key
      #     bindkey '^[[H' beginning-of-line                                # Home key
      #     if [[ "''${terminfo[khome]}" != "" ]]; then
      #     bindkey "''${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
      #     fi
      #     bindkey '^[[8~' end-of-line                                     # End key
      #     bindkey '^[[F' end-of-line                                     # End key
      #     if [[ "''${terminfo[kend]}" != "" ]]; then
      #     bindkey "''${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
      #     fi
      #     bindkey '^[[2~' overwrite-mode                                  # Insert key
      #     bindkey '^[[3~' delete-char                                     # Delete key
      #     bindkey '^[[C'  forward-char                                    # Right key
      #     bindkey '^[[D'  backward-char                                   # Left key
      #     bindkey '^[[5~' history-beginning-search-backward               # Page up key
      #     bindkey '^[[6~' history-beginning-search-forward                # Page down key
      #     # Navigate words with ctrl+arrow keys
      #     bindkey '^[Oc' forward-word                                     #
      #     bindkey '^[Od' backward-word                                    #
      #     bindkey '^[[1;5D' backward-word                                 #
      #     bindkey '^[[1;5C' forward-word                                  #
      #     bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
      #     bindkey '^[[Z' undo                                             # Shift+tab undo last action
      #     # Theming section
      #     autoload -U colors
      #     colors
      #
      #     ## VERY IMPORTANT!!!!
      #     unset RPS1 RPROMPT
    '';
  };
}
