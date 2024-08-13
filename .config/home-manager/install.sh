#! /bin/bash
set -euxo pipefail

# Use Wayland in Pop OS (many graphical apps don't work in Wayland currently)
# sudo sed -i '' 's/WaylandEnable=false/WaylandEnable=true/g' /etc/gdm3/custom.conf
# This will log out
# systemctl restart gdm.service

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
. /nix/var/profiles/default/etc/profile.d/nix-daemon.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-channel --update
nix run home-manager/master -- switch -b backup --flake .#"jesse"

# install docker
sudo curl -fsSL https://get.docker.com | sh
sudo groupadd docker || true # don't fail if the docker group already exists
sudo usermod -aG docker $USER

# Resolve (hopefully) the white flickering that keeps happening
# https://www.kernel.org/doc/html/latest/gpu/amdgpu/module-parameters.html
# https://support.system76.com/articles/kernelstub/
# sudo kernelstub -a "amdgpu.sg_display=0" -v
# cat /etc/kernelstub/configuration | grep "amdgpu.sg_display"


command -v zsh | sudo tee -a /etc/shells

# Requires logging out and back in
sudo chsh -s "$(command -v zsh)" "${USER}"
