# My Sway Configuration File

## Setup 

```bash
sudo pacman -S i3status # for status bar
sudo pacman -S swaybg # for background
sudo pacman -S grim wl-clipboard slurp # for screenshot
sudo pacman -S wdisplays # display adjuster
sudo pacman -S pavucontrol # voice control
```

- Use [Iosevka-Nerd-Fonts](https://www.nerdfonts.com/font-downloads) (terminal version). Download it from the link and unzip it. Then, install the font by copying the `.ttc` or `.ttf` files to your system's font directory and refreshing the font cache:
```bash
sudo mkdir -p /usr/local/share/fonts
unzip -j PkgTTC-Iosevka-*.zip '*.ttc' -d /usr/local/share/fonts/
# or
unzip -j IosevkaTerm.zip '*.ttf' -d /usr/local/share/fonts/
fc-cache -fv
```

## For Virtual Machine Setup

```bash
sudo pacman -S --needed \
  qemu \
  libvirt \
  virt-manager \
  virt-viewer \
  dnsmasq \
  vde2 \
  bridge-utils \
  ebtables \
  iptables-nft \
  dmidecode \
  ovmf \
  edk2-ovmf \
  swtpm \
  spice-gtk \
  spice-protocol \
  usbredir
```

### Enable libvirtd

```bash
sudo systemctl enable --now libvirtd.service
```

### Add User to libvirtd Group

```bash
sudo usermod -aG libvirt $(whoami)
```

