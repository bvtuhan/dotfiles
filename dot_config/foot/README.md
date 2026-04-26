# Foot Config

- Use [Iosevka-Nerd-Fonts](https://www.nerdfonts.com/font-downloads) (terminal version). Download it from the link and unzip it. Then, install the font by copying the `.ttc` or `.ttf` files to your system's font directory and refreshing the font cache:
```bash
sudo mkdir -p /usr/local/share/fonts
unzip -j PkgTTC-Iosevka-*.zip '*.ttc' -d /usr/local/share/fonts/
# or
unzip -j IosevkaTerm.zip '*.ttf' -d /usr/local/share/fonts/
fc-cache -fv
```
