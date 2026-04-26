# Neovim Config

My custom neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Custom adjustments are made like migrating [doom emacs](https://github.com/doomemacs/doomemacs) keybindings for buffer and lsp. If you are already familiar with doom keybindings, this can be a starting point of your `nvim` configuration.

## Installation

```bash
git clone git@github.com:bvtuhan/nvim.git ~/.config/nvim
# For Windows (PowerShell)
git clone git@github.com:bvtuhan/nvim.git $env:LOCALAPPDATA\nvim
``` 

## Dependencies

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y \
  git \
  curl \
  wget \
  unzip \
  zip \
  tar \
  ripgrep \
  fd-find \
  build-essential \
  cmake \
  pkg-config \
  ninja-build \
  nodejs \
  npm \
  xclip \
  wl-clipboard \
  python3 \
  python3-pip \
  luarocks \
  libtool \
  autoconf \
  automake \
  g++ \
  make \
  librsvg2-bin

# Arch Linux
sudo pacman -Syu --needed \
  git \
  curl \
  wget \
  unzip \
  zip \
  tar \
  ripgrep \
  fd \
  base-devel \
  cmake \
  pkgconf \
  ninja \
  nodejs \
  npm \
  python \
  python-pip \
  luarocks \
  xclip \
  wl-clipboard \
  librsvg

# Windows
pacman -S --needed \
  git \
  curl \
  unzip \
  zip \
  tar \
  mingw-w64-x86_64-toolchain \
  mingw-w64-x86_64-make \
  mingw-w64-x86_64-cmake \
  mingw-w64-x86_64-pkgconf \
  mingw-w64-x86_64-ripgrep \
  mingw-w64-x86_64-fd \
  mingw-w64-x86_64-librsvg

choco install nodejs-lts -y
choco install llvm -y

cargo install --locked tree-sitter-cli
```

Do not forget to add `C:\msys64\usr\bin` and `C:\msys64\mingw64\bin` to `$PATH`.

## Fonts

- Use [Iosevka-Nerd-Fonts](https://www.nerdfonts.com/font-downloads) (terminal version). Download it from the link and unzip it. Then, install the font by copying the `.ttc` or `.ttf` files to your system's font directory and refreshing the font cache:
```bash
sudo mkdir -p /usr/local/share/fonts
unzip -j PkgTTC-Iosevka-*.zip '*.ttc' -d /usr/local/share/fonts/
# or
unzip -j IosevkaTerm.zip '*.ttf' -d /usr/local/share/fonts/
fc-cache -fv
```
