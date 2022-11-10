#!/bin/bash

INSTALL_DRIVE=/dev/sda

# create partitions
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${INSTALL_DRIVE}
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +200M # 100 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

# format partitions
mkfs.fat -F 32 ${INSTALL_DRIVE}1
mkfs.ext4 ${INSTALL_DRIVE}2

# mount partitions
mkdir -p /mnt/boot
mount ${INSTALL_DRIVE}2 /mnt
mount ${INSTALL_DRIVE}1 /mnt/boot

# install basic packages
pacstrap /mnt base linux linux-firmware sudo efibootmgr networkmanager intel-ucode polkit

genfstab -U /mnt >> /mnt/etc/fstab

# chroot to new system
arch-chroot /mnt /bin/bash <<EOF

# setup locale
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP="pl"" >> /etc/vconsole.conf

systemctl enable NetworkManager

# create user
useradd -m -G wheel -s /bin/bash ketrab
echo 1 | passwd ketrab --stdin
echo '%wheel ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo

# setup bootloader
eval $(blkid ${INSTALL_DRIVE}2 \| grep -oP 'PARTUUID\=\".+?\"')
efibootmgr --create --disk ${INSTALL_DRIVE} --part 1 --label "Arch" --loader /vmlinuz-linux --unicode 'root=PARTUUID=\$PARTUUID rw initrd=\intel-ucode.img initrd=\initramfs-linux.img rootfstype=ext4 quiet splash i915.fastboot=1'

EOF
reboot