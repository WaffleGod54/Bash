#!/bin/bash
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install cryptsetup -y
spacer="---------------------------------------------------------------------------------------------"
lsblk
echo -e "\n$spacer\nEnter the disk ID to encrpyt,\nThis WILL destroy all data on the disk\n$spacer"
read disk
echo -e "\n$spacer\nEnter the ID for the encrypted voume\n$spacer"
read ID
echo -e "\n$spacer\nEnter the Directory of where you want to mount the disk\n$spacer"
read directory
echo -e "\n$spacer\nEnter the code to use for the key\n$spacer"
read code
cd $directory || exit 1
sudo mkfs.ext4 /dev/$disk
sudo cryptsetup --verify-passphrase luksFormat /dev/$disk -c aes -s 256 -h sha256
sudo cryptsetup luksOpen /dev/$disk $ID
sudo mkfs -t ext4 -m 1 /dev/mapper/$ID
sudo mount /dev/mapper/$ID $directory
sudo chown -R pi:pi $directory
sudo dd if=/dev/urandom of=/bin/key/$code bs=1024 conv=noerror progress=status
sudo chmod 400 /bin/key/$code
sudo cryptsetup luksAddKey /dev/$disk /bin/key/$code
sudo echo -e "$ID	/dev/$disk	/bin/key/$code luks" >> /etc/crypttab
sudo echo -e "/dev/$disk	/bin/key/$code	ext4	defaults,ro 0 0" >> /etc/fstab
