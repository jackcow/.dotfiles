#!/bin/bash

# Fedora Setup Script
# Jacky Cao
# 2022 10 25

# DNF config
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
echo "defaultyes=True
keepcache=True" >> /etc/dnf/dnf.conf

sudo dnf update

# Register SSH key
eval "$(ssh-agent -s)" #works in bash
ssh-add ~/.ssh/id_rsa

# fish shell
sudo dnf install -y fish util-linux-user
chsh -s /usr/bin/fish

mkdir -p /home/$USER/.local/bin
set -Ua fish_user_paths /home/$USER/.local/bin

# Repositories
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y dnf-plugins-core
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# Power Saving
sudo dnf install tlp tlp-rdw
sudo systemctl enable tlp

# Programs
sudo dnf install -y vlc gnome-tweaks gnome-extensions-app easyeffects neofetch
flatpak install -y flatseal
flatpak install -y flathub com.mattjakeman.ExtensionManager
flatpak install -y flathub com.usebottles.bottles
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub com.visualstudio.code
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.chromium.Chromium

# Game Related
flatpak install -y flathub com.valvesoftware.Steam
flatpak install flathub org.ryujinx.Ryujinx
flatpak install flathub com.moonlight_stream.Moonlight
flatpak install flathub io.github.hmlendea.geforcenow-electron
flatpak install flathub org.prismlauncher.PrismLauncher

# Codecs
sudo dnf groupupdate sound-and-video
sudo dnf install -y libdvdcss
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

# Git
sudo dnf install -y git git-lfs
git-lfs install
flatpak install -y gitkraken

# Fonts
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Themes
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh
cp "./.themes/*" "$HOME/.themes/"
cp "./.config/*" "$HOME/.config/"
cp "./.local/share/fonts/*" "$HOME/.local/share/fonts/"
fc-cache -v
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig 

# Misc
sudo hostnamectl set-hostname "g14"
