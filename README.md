# Personal Home Manager Nix config

- home-manager switch --flake .#lain

add `experimental-features = nix-command flakes` to ~/.config/nix/ or /etc/nix/nix.conf) and restart daemon

## Installing nix and home-manager fedora
- Install nix determinate installer
	- https://github.com/DeterminateSystems/nix-installer
- Initialize a config/dot folder
	- nix run home-manager -- init --switch .
- nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager 
- nix-channel --update
- nix-shell '<home-manager>' -A install

## Installing nix and home-manager in archlinux

- pacman -S --needed git base-devel nix
- sudo sytemctl enable nix-daemon.service
- sudo usermod -a -G nix-users l  (if not nix-users then nixbld group)
- nix-channel --add https://nixos.org/channels/nixpkgs-unstable
- nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager 
- nix-channel --update
- nix-shell '<home-manager>' -A install


### Resources
- https://wiki.archlinux.org/title/Nix
- https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
