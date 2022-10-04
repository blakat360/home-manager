#!/bin/bash

# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
# need to restart shell to make env vars show up
bash
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# install home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
# enable flake support
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
# switch to the config
home-manager switch --flake 'flake.nix#sigkill'
cwd=$(pwd)
cd ~
ln -s .xsession .xinitrc
cd $cwd
