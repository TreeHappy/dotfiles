#!/bin/bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --extra-conf "sandbox = false" --init none --no-confirm

PATH="${PATH}:/nix/var/nix/profiles/default/bin"

#
# https://github.com/NixOS/nix/issues/3435#issuecomment-1642654775
# This is... but other solutins can't avoid following error
# error: could not set permissions on '/nix/var/nix/profiles/per-user' to 755: Operation not permitted
sudo chown --recursive $(whoami) /nix

mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" | tee ~/.config/nix/nix.conf
mkdir -p ~/.config/home-manager/dotfiles/zellij
bash /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
rm .bashrc
rm .profile

sed -i 's/halcyon/'$(whoami)'/g' .config/home-manager/home.nix
sed -i 's/halcyon/'$(whoami)'/g' .config/home-manager/flake.nix
nix shell home-manager -c home-manager switch
echo "installing astrovim 🌝"
nix-shell -p git --command "git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim"
mkdir -p ~/.config/nvim/lua/user/
cp ~/.config/home-manager/nvim/* ~/.config/nvim/lua/user/
