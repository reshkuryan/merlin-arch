#!/bin/bash
mkfs.fat -F32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.btrfs /dev/nvme0n1p3

swapon /dev/nvme0n1p2
mount /dev/nvme0n1p3 /mnt
mkdir -p /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi

cat <<EOF > /mnt/etc/pacman.d/mirrorlist
Server = http://mirror.ditatompel.com/archlinux/\$repo/os/\$arch
Server = https://mirror.ditatompel.com/archlinux/\$repo/os/\$arch
EOF

pacstrap /mnt base linux linux-firmware sof-firmware neovim networkmanager btrfs-progs

genfstab -U /mnt >> /mnt/etc/fstab


arch-chroot /mnt /bin/bash <<EOF

ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

hwclock --systohc

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "vassago" > /etc/hostname

echo "root:yourpassword" | chpasswd

pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

EOF
