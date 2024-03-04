#!/usr/bin/env bash

loadkeys fr-pc   # my keymap
setfont ter-132b # High-DPI screens
timedatectl

echo "EFI paritition ?"
read EFI

echo "SWAP paritition ?"
read SWAP

echo "Root(/) paritition ?"
read ROOT

echo "username ?"
read USER

echo "password ?"
read PASSWORD

echo "KDE or... NOTHING ?"
echo "1. KDE"
echo "2. NOTHING"
read DESKTOP

# make filesystems
echo -e "\nCreating Filesystems...\n"

mkfs.vfat -F32 -n "EFISYSTEM" "${EFI}"
mkswap "${SWAP}"
swapon "${SWAP}"
mkfs.ext4 -L "ROOT" "${ROOT}"

# mount target
mount -t ext4 "${ROOT}" /mnt
mkdir /mnt/boot
mount -t vfat "${EFI}" /mnt/boot/

echo "--------------------------------------"
echo "-- INSTALLING Arch Linux            --"
echo "--------------------------------------"
pacstrap -K /mnt base base-devel --noconfirm --needed

# kernel
pacstrap -K /mnt linux linux-firmware linux-headers --noconfirm --needed

echo "--------------------------------------"
echo "-- Setup Dependencies and Stuff     --"
echo "--------------------------------------"

pacstrap /mnt networkmanager wireless_tools neovim intel-ucode bluez bluez-utils blueman git firefox kitty vlc jdk-openjdk --noconfirm --needed

# fstab
genfstab -U /mnt >>/mnt/etc/fstab

echo "--------------------------------------"
echo "-- Bootloader Installation  --"
echo "--------------------------------------"

# grub
pacman -S grub efibootmgr intel-ucode --noconfirm --needed
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# user
useradd -m $USER
usermod -aG wheel $USER
echo $USER:$PASSWORD | chpasswd
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "-------------------------------------------------"
echo "-- Setup Language to EN and set locale         --"
echo "-------------------------------------------------"

sed -i 's/^#fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >>/etc/locale.conf

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

echo "archlinux" >/etc/hostname

echo "-------------------------------------------------"
echo "-- Display and Audio Drivers                   --"
echo "-------------------------------------------------"

pacman -S xorg pulseaudio --noconfirm --needed

systemctl enable NetworkManager bluetooth.service

#DESKTOP ENVIRONMENT
if [[ $DESKTOP == '1' ]]; then
	pacman -S plasma kde-applications sddm --noconfirm --needed
	systemctl enable sddm
else
	echo "You have choosen to install desktop yourself, good luck !"
fi

echo "-------------------------------------------------"
echo "-- Install Complete, You can reboot now        --"
echo "-------------------------------------------------"
