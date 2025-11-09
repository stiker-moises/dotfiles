```
Install Script
==============

Step 1. Install NixOS, no desktop:

Step 2. Get connected to WiFi, ethernet is automatic:

$ nmtui

Step 3. Get the script ready, make sure to delete the dotfiles folder when you're done:

$ nix-shell -p git

$ git clone https://github.com/stiker-moises/dotfiles.git

$ cd dotfiles

$ cp ./.z* ~/

$ sudo cp -n -r ./etc/ /

Step 4. Set hostname, import sys.nix, and <intel amd nvidia>.nix depending on your GPU:

$ sudo nano /etc/nixos/configuration.nix

$ sudo nixos-rebuild switch --upgrade

$ zsh

$ setupeverything

Step 5. hash out networkmanager line, add iwd.nix:

$ snv /etc/nixos/configuration.nix

Step 6. Enable unstable (optional)

$ doas nix-channel --add https://nixos.org/channels/nixos-unstable nixos

$ upd
    B. Add your software by editing by copying my anarchy-desktop.nix to your <hostname>.nix:

        $ doas cp /etc/nixos/anarchy-desktop.nix /etc/nixos/$(cat /etc/hostname).nix

        $ snv /etc/nixos/
```
