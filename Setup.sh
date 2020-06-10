#!/bin/sh
cd /
ln -sf /usr/share/zoneinfo/Canada/Eastern /etc/localtime
hwclock --systohc
echo "en_CA.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_CA.UTF-8" >> /etc/locale.conf
echo "gateway" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "127.0.1.1 gateway" >> /etc/hosts
echo "192.168.1.213 laptop" >> /etc/hosts
passwd
useradd -mG users,wheel -s /bin/bash sebastian
passwd sebastian
pacman -S grub dhcpcd xorg xorg-server xorg-xinit xfce4 xfce4-goodies lightdm lightdm-gtk-greeter firefox terminator \
keepassxc wget krdc nautilus virtualbox rsync evince transmission-gtk xf86-video-intel openssh nano efibootmgr \
os-prober papirus-icon-theme scons
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig
systemctl enable dhcpcd ligthdm sshd
cd tmp
sudo -u sebastian git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u sebastian makepkg -si
cd ..
rm -rf yay
cd ..
sudo -u sebastian yay -S dockbarx xfce4-dockbarx-plugin balena-etcher plata-theme jdk8
cd /opt
wget https://github.com/pokemon-speedrunning/gambatte-speedrun/archive/r717.tar.gz
tar xvf r717.tar.gz
gambatte-speedrun/scripts/build_qt.sh
cd /
