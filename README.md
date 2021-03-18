# dotfiles

My config files!

## Initial setup

1. Install [nix](https://nixos.org/download.html)
1. Install [home-manager](https://github.com/nix-community/home-manager) (following instructions for the unstable branch)
1. (Optional) Install programs not managed by nix:
    - [Hammerspoon](https://www.hammerspoon.org/)
    - [Karabiner Elements](https://karabiner-elements.pqrs.org/)
    - NOTE: the config for these will be automatically linked by home-manager, but you stil lhave to install them manually
1. Link home.nix into a place home-manager will find it: `ln -s ./home.nix  ~/.config/nixpkgs/home.nix` (from the repo's root)
1. Run `home-manager switch` to activate the setup
1. Update your user (or terminal app) settings to use the version of zsh installed by nix as your default shell (`~/.nix-profile/bin/zsh`)

## Making changes

- Just modify the sources and re-run `home-manager switch`.
- You can also run `home-manager build` to build the new environment's derivation without activating it.
