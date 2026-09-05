source /usr/share/cachyos-fish-config/cachyos-config.fish

set -gx PYENV_ROOT $HOME/.pyenv

fish_add_path $PYENV_ROOT/bin
fish_add_path ~/.config/emacs/bin
fish_add_path ~/zls/zig-out/bin

set -gx nvm_default_version 25

status --is-interactive; and pyenv init - | source

alias sway-gpu='sway --unsupported-gpu'
alias go-dot='cd ~/.local/share/chezmoi/'
alias godot='cd ~/.local/share/chezmoi/'
alias shn='shutdown +0'
alias sleep='sudo systemctl sleep'
alias suspend='sudo systemctl suspend'
alias geforcenow='flatpak run com.nvidia.geforcenow'
functions -e wget


# Added by Antigravity CLI installer
set -gx PATH "/home/batuhan/.local/bin" $PATH
