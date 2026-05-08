source /usr/share/cachyos-fish-config/cachyos-config.fish

set -gx PYENV_ROOT $HOME/.pyenv

fish_add_path $PYENV_ROOT/bin
fish_add_path ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.config/emacs/bin
fish_add_path ~/zls/zig-out/bin

status --is-interactive; and pyenv init - | source

alias sway-gpu='sway --unsupported-gpu'
alias go-dot='cd ~/.local/share/chezmoi/'
alias geforcenow='flatpak run com.nvidia.geforcenow'
functions -e wget
