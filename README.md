# MerlinArch

### Description
MerlinArch is a shell script designed to automate the installation process of the Arch Linux operating system.

### Disclaimer
- Make sure you have configured the necessary partitions before running MerlinArch.
- This project is for personal use. I do not take responsibility for any risks involved.

#### What does this script do?
1. Formatting partitions:

    - Formats nvme0n1p1 as FAT32.
    - Formats nvme0n1p2 as swap.
    - Formats nvme0n1p3 as Btrfs.

2. Activating swap and mounting partitions:

    - Activates the swap partition.
    - Mounts the Btrfs partition to /mnt.
    - Creates the /mnt/efi directory
    - mounts the FAT32 partition to this directory.

3. Configuring the mirror list for pacman with the specified server.

4. Installing base system packages:

    - Installs base, linux, linux-firmware, sof-firmware, neovim, networkmanager, btrfs-progs.

5. Generating fstab for the mounted file systems.

6. Chrooting into the new system in /mnt to perform further configurations:

    - Sets the timezone to Asia/Jakarta.
    - Sets the hardware clock.
    - Enables the en_US.UTF-8 locale.
    - Sets the system language configuration.
    - Sets the hostname to "vassago".
    - Sets the root password.
    - Installs GRUB and efibootmgr.
    - Installs GRUB to the EFI system and generates the GRUB configuration.

#### Installing

```
git clone https://github.com/reshkuryan/merlinarch.git
```

## Usage
#### Make Executable:

Ensure the script has executable permissions using the following command:

```
chmod +x merlin.sh
```

#### Set a password
Edit the "yourpassword" string on line 35 in merlinarch.sh with vi or Vim, then update it to input the root password automatically

```
vim merlinarch.sh
echo "root:yourpassword" | chpasswd
```

#### Running the Script
Execute the script by typing:
```
./merlin.sh
```
