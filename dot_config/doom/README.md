# Doom Config

I mainly use `doom` for the org-mode. The configuration does not provide an IDE like experience. However, `flycheck` is enabled globally, which gives you a basic syntax checking in programming buffers. Additionally, `eglot` can be enabled on demand manually with `M-x eglot` in programming buffers. 

I use `org-fragtog` for rendering the LaTeX fragments in org-mode, and `org-download` for downloading images from clipboard and inserting them into org files `(Ctrl + Alt + V)`. 

For your own mental health, do not use `doom` on Windows (i did). The `WSL` experience is tolerable, but still not as good as on Linux (for instance, `org-download` does not work on WSL at all).

## Linux Installation

```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
git clone  git@github.com:bvtuhan/doom.git ~/.config/doom
~/.config/emacs/bin/doom install
doom sync
```

- add the `~/.config/emacs/bin/doom` into PATH

```bash
export PATH="$HOME/.config/emacs/bin:$PATH"
```

## Windows Installation

*For your own sanity, do not use emacs on Windows (WSL is ok).* But if you still want to, here is how you can set it up:

1. Install Emacs (run ps as admin)
```ps 
$ choco install emacs
```

2. Install Doom Emacs 
```ps
git clone https://github.com/doomemacs/doomemacs.git $HOME\.emacs.d
```

3. Set the `HOME` Environment Variable
   Under System Variables, click New...
```
   Variable name: HOME
   Variable value: C:\Users\batuhan
```

4. Add `C:\Users\batuhan\.emacs.d\bin` to your `PATH`

5. Install doom-emacs
```ps
$ doom install
```

6. Install the configuration
```ps
$ git clone git@github.com:bvtuhan/doom.git $HOME\.doom.d
$ doom sync
```

## `eglot` Keybindings

`eglot` is loaded lazily, you have to enable it in the current buffer manually with `M-x eglot`. Use `SPC c` as the prefix for all LSP related commands. Here are some of the most useful ones:
- Format buffer: SPC c f
- Rename symbol: SPC c r
- Code actions: SPC c a
- Variable/Code documentation : Shift + k or SPC c k
- Goto def/refs: gd 

### Using `eglot-booster`

If you decided to use `eglot` then you also have to install the [`eglot-booster`](https://github.com/jdtsmith/eglot-booster):

```bash
cargo install emacs-lsp-booster
```

## Ubuntu `clangd` Configuration for `flycheck`

```elisp

## Ubuntu `clangd` Configuration for `flycheck`

Create a `config.yaml` file under `/.config/clangd/` and add this:

```yaml
# ~/.config/clangd/config.yaml
CompileFlags:
  Add:
    - -isystem
    - /usr/include/c++/13
    - -isystem
    - /usr/include/x86_64-linux-gnu/c++/13
    - -isystem
    - /usr/include/c++/13/bits
```
There is a weird bug with `clangd` where it cannot find the standard library headers, so you have to add the include paths manually.

You have to adjust the version depending on the `gcc` you have installed. You can check the version with `gcc --version`. For instance, if you have `gcc 12` installed, you should replace `13` with `12` in the paths.

## Spell Checker Dependencies (`jinx`)

``` bash
# for debian/ubuntu
$ sudo apt install libenchant-2-dev pkg-config build-essential

# for arch 
sudo pacman -S base-devel pkg-config pkgconf enchant hunspell hunspell-en_US
```

You have to install [MSYS2](https://www.msys2.org/) on Windows to get the spell checking working.

``` bash
pacman -Syu
pacman -S mingw-w64-x86_64-enchant pkg-config mingw-w64-x86_64-toolchain
# all spells go brrr
pacman -S mingw-w64-x86_64-hunspell-en
pacman -S mingw-w64-x86_64-aspell
pacman -S mingw-w64-x86_64-nuspell
echo 'export PATH="/mingw64/bin:$PATH"' >> ~/.bashrc
hunspell -d en_US -D

mkdir -p ~/.local/share/dict
tail -n +2 /mingw64/share/hunspell/en_US.dic \
  | sed 's#/.*##' \
  | tr -d '\r' \
  > ~/.local/share/dict/en_US.words
```

Do not forget to add `C:\msys64\mingw64\bin` and `C:\msys64\usr\bin` to PATH.

## `org-fragtog` Dependencies

You have to install `texlive-full` for `org-fragtog` to work. 

```bash
# Ubuntu
sudo apt install texlive-full # or apt-get

# Arch Linux
sudo pacman -S texlive-full
```

I have tested `org-fragtog` on Windows as well, and it seems like it does not work at all. I installed [MiKTeX](https://miktex.org/download) and added it into PATH, but still no luck.

If you have any idea how to make `org-fragtog` work on Windows, please let me know. 

Make sure that you have `dvisvg` and `dvipng` installed and added to PATH as well after installing `textlive-full` or `MiKTeX`.

## `org-download` Dependencies

For Linux, depending on the desktop environment you are using, you might need to install `xclip` or `wl-clipboard` for `org-download` to work.

```bash
# For X11
sudo apt install xclip
# For Wayland
sudo apt install wl-clipboard
```

For Windows, you have to install [ImageMagick](https://imagemagick.org/script/download.php) and add it to PATH for `org-download` to work. (command `magick` should be available in the terminal environment)

`WSL`does not support clipboard access for some reason, therefore `org-download` does not work on it.
