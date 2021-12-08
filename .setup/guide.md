# A comprehensive guide to Arch

---

  

# Installation

## Pre-flight checks

### Verify ISO signature

Straight ripped from the Arch wiki:


*It is recommended to verify the image signature before use, especially when downloading from an HTTP mirror, where downloads are generally prone to be intercepted to [*serve malicious images*](https://www2.cs.arizona.edu/stork/packagemanagersecurity/attacks-on-package-managers.html).*
  
*On a system with [GnuPG](https://wiki.archlinux.org/title/GnuPG) installed, do this by downloading the PGP signature (under Checksums in the [Download](https://archlinux.org/download/) page) to the ISO directory, and [*verifying*](https://wiki.archlinux.org/title/GnuPG#Verify_a_signature) it with:*
```bash
gpg --keyserver-options auto-key-retrieve --verify archlinux-version-x86_64.iso.sig
```

*Alternatively, from an existing Arch Linux installation run:*
```bash
pacman-key -v archlinux-version-x86_64.iso.sig
```

### Determining boot type
You're either going to be booted in **UEFI** or **BIOS/CSM**, knowing this is important for 2 reasons:
- the partition layout for your bootloader & system is going to be different based on the mode
- this guide will not cover BIOS/CSM, there are intricate limitations that should be left up to wikis and in-depth guides for specific installations (IMO)

You can use `ls /sys/firmware/efi/efivars` to determine the mode. If all of the directories (`.../efi` & `.../efivars`) exist, you're in UEFI mode. Otherwise, you're in BIOS/CSM mode.  
Reboot and correct your BIOS settings / installation media if you're in the wrong mode now, in a few steps it will be too late and you'll lose all your progress if you decide to change then.

### Connecting to the network (internet)
Straight up, this will either be the simplest thing ever, or a pain in the ass.

Connecting over an ethernet patch cable should be a plug-&-play experience, setting up a wifi connection on the other hand, not so much. Luckily the Arch live installation already has all of the tools you need to connect to all standard networks (WEP, WPA2 protected).  
I also recommend going via a cable for other reasons, such as stability & speed - as you might be downloading over 2G of files.

#### Setting up a wifi connection
To find the interface name of your wireless adapter, you can use [iw](https://wireless.wiki.kernel.org/en/users/documentation/iw).
```bash
iw dev
```

You can check the state of your wireless connection via
```bash
iw dev <interface> link
```

You'll now probably need to bring *up* your interface
```bash
ip link set <interface> up
```

After that, you can scan for the nearby networks (if you already know the SSID you can skip this)
```bash
iw dev <interface> scan | less
```

Connecting to a open access point is really easy, you can just use `iw` for that:
```bash
iw dev <interface> connect <ssid>
```

For authenticated APs, the best option is likely [wpa_supplicant](https://wiki.archlinux.org/index.php/wpa_supplicant). Let `wpa_passphrase` generate a configuration file at `/etc/wpa_supplicant.conf` using your SSID & password (it will ask for your password via `stdin`). After that, just pass the configuration to `wpa_supplicant`, and it will start and manage the connection for you. Its output is not useful, so use one of the previously mentioned commands to check for a successful connection.

```bash
wpa_passphrase <ssid> >> /etc/wpa_supplicant.conf
wpa_supplicant -B -D wext -i <interface> -c /etc/wpa_supplicant.conf
```

### Pacman databases & mirrors
When you'll be installing packages to your new system, you'll be pulling them from the internet via what is called [mirrors](https://wiki.archlinux.org/itle/mirrors).

These are essentially package repositories that are *copies* of the master Arch repository hosted on their servers. To handle scaling, instead of deploying hundreds of servers across the world, they utilize these mirrors - which are mostly community run servers that pull data at a set interval from the master servers. 

Each Arch system has a local list of mirrors that it uses to pull packages from - it has multiples as backups. It is important to pick mirrors which are reliable & fast - where the speed likely depends on how close they are to you.  
You could do this manually, guesstimating by their names and locations, but of course, there are tools for that - [reflector](https://wiki.archlinux.org/title/reflector).

#### Updating mirrorlist /w reflector
You can check your mirrorlist in `/etc/pacman.d/mirrorlist`, if the names and server locations (go by the top level domain) sound sane to you, `reflector.timer` has likely already run, benchmarked a bunch of servers and chosen the best.  
If not, or you just want to make sure anyways, you can trigger it by starting it's service. This might take a few minutes.
```bash
systemctl start reflector.service
```

Depending on when you've downloaded the ISO, you might want to now also update your local databases.
```bash
pacman -Syy
```

## Partitioning
I'm going to go over a few types of partitioning schemes, but all of them *require* you to at least create a few basic partitions. The go-to tools for this are [`cfdisk`](https://man.archlinux.org/man/cfdisk.8.en) or its less GUI counterpart [`fdisk`](https://wiki.archlinux.org/index.php/Fdisk).  
They are pretty intuitive and only require a few minutes of tinkering to figure out.

In the olden days, you just set up primary partitions on your drive & setup a filesystem on each. Now, there are more, and more importantly *better* ways of doing this. The list goes from the most bleeding-edge and feature right option, to the least.

### Btrfs
*More information on this system [here](https://wiki.archlinux.org/title/btrfs) & [here](https://btrfs.wiki.kernel.org/index.php/Main_Page).*
*There is also a great LUKS + Btrfs setup guide (which I essentially copied) [here](https://nerdstuff.org/posts/2020/2020-004_arch_linux_luks_btrfs_systemd-boot/)*

Btrfs has recently (in the last 3-4 years) gotten some good traction - although it's been in the Kernel for a while now, only some recent 5.x releases have added much needed stability & features.

#### Partitions
Create 2 partitions, 1 for your ESP ([EFI System Partition](https://wiki.archlinux.org/title/EFI_system_partition)) and the other one for the rest of your system. Don't worry, we'll split it up into *subvolumes* later.
```bash
cfdisk
```
You'll want to perform a few steps:
- setup a GTP partition table
- create a partition of size `500M` of type `EFI System`, we'll call this `sda1`
- create a partition that will use the rest of the space on the disk, leave type as `Linux filesystem`, we'll call this `sda2`
- we're done, write to disk by selecting write and typing `yes`

#### Setup encryption
*See [wiki](https://wiki.archlinux.org/title/Dm-crypt/Device_encryption) for more information*
You can skip this step if you want, but physical access to your machine will allow access to all of your data.

Create an encrypted container for the root file system (you need to define a passphrase):
```bash
cryptsetup luksFormat /dev/sda2
```

Open the container ("luks" is just a placeholder, you can use a name of your choice, but remember to adopt the subsequent steps of the guide accordingly):
```bash
cryptsetup open /dev/sda2 luks
```

#### Format the partitions
Format the EFI partition with FAT32 and give it the label EFI - you can choose any other label name:
```bash
mkfs.vfat -F32 -n EFI /dev/sda1
```

Format the root partition with Btrfs and give it the label *root* - you can choose any other label name.

**With encrpytion**
*note: adjust the name *luks* according to your choice when using `cryptsetup open`*
```bash
mkfs.btrfs -L root /dev/mapper/luks
```
**Without encryption**
```bash
mkfs.btrfs -L root /dev/sda2
```

#### Create and mount subvolumes
Create [subvolumes](https://wiki.archlinux.org/index.php/Btrfs#Subvolumes) for root, home, opt, srv, var, [snapshots](https://wiki.archlinux.org/index.php/Btrfs#Snapshots) and the entire Btrfs file system. You can leave out any of the second-to-last 4 as seen fit (opt, srv, var, snapshots), but there is not many reasons why you should.

```bash
mount /dev/mapper/luks /mnt
btrfs sub create /mnt/@
btrfs sub create /mnt/@home
btrfs sub create /mnt/@opt
btrfs sub create /mnt/@srv
btrfs sub create /mnt/@var
btrfs sub create /mnt/@snapshots
unmount /mnt
```

Now we want to start creating the hierarchy which our system will actually run on - which means mounting the root partition properly, creating folders for our subvolumes & mounting them properly. If you're interested in what all of these options do, and what others there are, check out the [Btrfs mount options section](https://man.archlinux.org/man/btrfs.5#MOUNT_OPTIONS).

Again, replace the `/dev/mapper/luks` with `/dev/sda2` if installing without encryption.
``` bash
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@ /dev/mapper/luks /mnt
```
All the guides I've seen use the `space_cache` option in this step, but I've always gotten an error by using it - if you're encountering the same issue, just leave it out, for some reason it's going to use it anyways, as it will appear in our `fstab` when generating it later.

Create folder for the subvolumes.
```bash
mkdir -p /mnt/{boot,home,opt,srv,var,.snapshots,btrfs}
```
Notice the dot in `.snapshots` this is important, as is the `btrfs` folder. This is going to act as our "root" mountpoint for managing subvolumes. Excerpt from the [Btrfs wiki](https://btrfs.wiki.kernel.org/index.php/SysadminGuide#Description):
> The top-level subvolume (with Btrfs id 5) (which one can think of as the root of the volume) can be mounted, and the full filesystem structure will be seen at the mount point; alternatively any other subvolume can be mounted (with the mount options subvol or subvolid, for example subvol=subvol_a) and only anything below that subvolume (in the above example the subvolume subvol_b, its contents, and file file_4) will be visible at the mount point.

For example, when deleting a subvolume, you'd do `btrfs sub delete /btrfs/@<subvol>`.

After this, we can continue mounting the rest of our subvolumes.
*note: tabs added for readability*
```bash
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@home		/dev/mapper/luks /mnt/home
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@opt		/dev/mapper/luks /mnt/opt
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@srv		/dev/mapper/luks /mnt/srv
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@var		/dev/mapper/luks /mnt/var
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@snapshots /dev/mapper/luks /mnt/.snapshots
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvolid=5		/dev/mapper/luks /mnt/btrfs

mount /dev/sda1 /mnt/boot
```

### LVM/EXT4

### Raw partitions + EXT4

## System installation
### Pacstrap
Description from the [Arch man pages for `pacstrap`](https://man.archlinux.org/man/pacstrap.8)
> pacstrap is designed to create a new system installation from scratch. The specified packages will be installed into a given directory after setting up some basic mountpoints. By default, the host system’s pacman signing keys and mirrorlist will be used to seed the chroot.
> If no packages are specified to be installed, the  _base_  metapackage will be installed.

This is the moment your installation... well.. actually becomes an installation.  
You can essentially install any and all packages from the [official repositories](https://wiki.archlinux.org/title/official_repositories) that you want now, but I'd recommend sticking to the most important ones for now. Here is the basic set of packages *that I think* most people will need:
|        Name        |                                   Purpose                                  |
|--------------------|----------------------------------------------------------------------------|
| **base**           | Minimal package set to define a basic Arch Linux installation              |
| **base-devel**     | Minimal group of developement oriented packages (make;sudo;gcc;sed... etc) |
| **linux**          | The Linux kernel and modules                                               |
| **linux-firmware** | Firmware files for Linux                                                   |

For more useful "base" packages, check out [base.csv](./setup/packages/base.csv).

***Let's goooo***
```bash
pacstrap /mnt base base-devel linux linux-firmware
```

### Generating an fstab file
The [fstab](https://wiki.archlinux.org/title/fstab) file, is used to define how system partitions, volumes, remote partitions or other block devices should be mounted into the file system.

Example (*comment with headers added for clarity*):
```fstab
# <device>        <dir>        <type>        <options>        <dump> <fsck>
/dev/sda1         /boot        vfat          defaults         0      2
/dev/sda2         /            ext4          defaults         0      1
/dev/sda3         /home        ext4          defaults         0      2
/dev/sda4         none         swap          defaults         0      0
```

***Warning: Kernel name descriptors are not [persistent](https://wiki.archlinux.org/title/Persistent_block_device_naming "Persistent block device naming") and can change each boot, they should not be used in configuration files.***

To create this file, we're going to use the filesystem structure we've mounted at `/mnt` in the [partitioning](#Partitioning) step & use a handy tool called [`genfstab`](https://man.archlinux.org/man/genfstab.8).
```bash
genfstab -U -p /mnt > /mnt/etc/fstab
```

Though, don't just take it for granted that the tool got all of your partitions right, manually open and check the file for any obvious errors, or to just add other extra partitions that you’d like to be mounted on boot.
```bash
vim /mnt/etc/fstab
```

## System configuration
Essentially all steps except for the [user account setup](#User_account_setup), [package installation](#Package_installation) & [boot manager setup](#Boot_manager_setup) are optional, but probably should be performed in one way or another.  
*note: all of these steps have to be performed in a chroot*

### Chrooting
[Chroot](https://wiki.archlinux.org/index.php/chroot) is used to essentially access a separate system on a disk as if you were booted into it. It has its limitations, the daemons, services, kernel modules are not loaded - you can imagine it as if you were accessing a system that is turned off. Cause that’s what you are doing. It is also used for jailing, but that is out of the scope for now.

Arch has its own chroot tool, called arch-chroot, you can use it for the next steps to finish the installation before rebooting - it is actually necessary to install a boot manager using chroot before rebooting, so I guess you *must use it for a few installation steps before rebooting*.

```bash
arch-chroot /mnt
```

*note: type `exit` to exit from chroot*

### Setup pacman databases
As at the beginning of this guide, you should check your package `mirrorlist`, update it using `reflector` and run pacman to synchronize your databases - it's not *really* necessary after a fresh pacstrap, but you learn to expect the unexpected when daily driving Linux.
```bash
pacman -Syy
```

### Localization
[Locales](https://wiki.archlinux.org/index.php/Locale) are used by [glibc](https://www.gnu.org/software/libc/) and other locale-aware programs or libraries for rendering text, correctly displaying regional monetary values, time and date formats, alphabetic idiosyncrasies, and other locale-specific standards.

You can either uncomment the desired locales in `/etc/locale.gen` manually, or use this command if you already know the names of your locales. You can replace `locale_name` with any locale name, such as `en_US.UTF-8`, or `sk_SK.UTF-8`.
```bash
sed -i '/^#locale_name/s/^#//' /etc/locale.gen
```

After you’ve uncommented all of the locales you want, you generate them using
```bash
locale-gen
```

You’ll also need to choose one of them as your system language, and create a LANG variable
```bash
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

### Time zone
As we are currently in chroot, setting the [time zone](https://wiki.archlinux.org/index.php/System_time#Time_zone) cannot be done through timedatectl, but you have two other options.

Manually symlink the desired time zone from /usr/share/zoneinfo into /etc/localtime, example:
```bash
ln -s /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
```
Or use an interactive tool
```bash
tzselect
```

### Hostname
Just like on pretty much any system, you can set a custom the [hostname](https://wiki.archlinux.org/index.php/Network_configuration#Set_the_hostname) - it will get used across the whole system to refer to your device (ex.: dhcp, bluetooth, syncthing & even online services)
```bash
echo  "hostname" > /etc/hostname
```

It is also recommended, but not necessary to add matching entries to `/etc/hosts`. If the system has a permanent (static) IP address, it should be used instead of 127.0.1.1.
```
127.0.0.1	localhost  
::1			localhost  
127.0.1.1	hostname.localdomain	hostname
```

### User account setup
Before you reboot, you must set up your user account - by default, root doesn’t have a password set, so it’s impossible to log into it. Setting the root password is still recommended, so that you can recover your user account if anything happened to it (lost `sudo` access, made your home directory inaccessible, etc).

So, assign root a password. I recommend generating a 6-8 random word password and storing it in a password manager, or any other encrypted or in-other-way secured file - you really won't need it unless something's gone very wrong.
```bash
passwd root
```

When adding your user, you can directly assign him some essential groups that are going to make your life easier in the long run.

|             Name             |                               Purpose                               |
|------------------------------|---------------------------------------------------------------------|
| **wheel**                    | Sudo related group                                                  |
| **disk**                     | Access to block devices                                             |
| **tty**/**dialout**/**uucp** | May be needed for access to the /dev/tty devices (serial, USB, etc) |
| **rfkill**                   | Kill certain processes without the need for root permissions        |
| **audio**                    | Required to make ALSA and OSS work in remote sessions               |

```bash
useradd -m -G wheel,disk,... -s /usr/bin/bash username  
passwd username
```

After you’ve got your user set up, don’t forget to either set the wheel group to have sudo access, or just add your username directly to the list, right under root with any permissions you like.
```bash
visudo
```

For easy access, and if you’ve not worried that other people might get into your computer (like a notebook or a public server), I recommend adding yourself to the end of the file as follows:
```
username ALL=(ALL) NOPASSWD:ALL
```

### Custom dotfiles/configs
At this point, you should be able to `su` to your user and pull any dotfiles/configs you want from the internet. I’d mostly focus on things that you can alter right now (without systemd or other services running), such as configuration files for `xorg` (`.xinitrc`, `.Xdefaults`, etc) and your `shell` (`.*rc`).

Or you can just clone this repository and use the `./install` script <3

### Package installation
You might want to install some packages in advance while you still have access to the internet through the installation image - especially packages related to [networking](https://wiki.archlinux.org/index.php/Network_configuration) - be it wifi or ethernet, you'll need some tools.  
These packages can range anywhere from tools like vim, git or ranger, all the way to different shells (zsh, fish) & window managers/desktop environments (xorg, i3, kde).

I recommend taking a look at my [categorized list of packages](./setup/packages) and installing at least [`tools.csv`](./setup/packages/tools.csv). As I currently still don't have a setup script written for these, you can use this one liner to install whatever package list you desire, or just install them one by one manually
```bash
yay -S $(tail -n +2 *.csv | awk -F "\"*,\"*" 'NF {print $2}')
```

If you don't want to go through that right now, you should at least install the [`NetworkManager`](https://wiki.archlinux.org/title/NetworkManager) package to handle your networking - it should handle and automate pretty much everything.

### Boot manager setup

You'll need to add extra hooks before the creation of your [initramfs](https://wiki.archlinux.org/title/Arch_boot_process#initramfs) by editing `/etc/mkinitcpio.conf` and adding one or more of these hooks depending on the setup you've chosen to go with in the [partitioning](#Partitioning) step.

|     Name    |              Purpose                  |
|-------------|---------------------------------------|
| **encrypt** | Root encryption using dm-crypt/LUKS   |
| **btrfs**   | For btrfs as the root filesystem      |
| **lvm2**    | For root setup on top of LVM          |

After that, you have to recreate the initramfs files.
```bash
mkinitcpio -p linux
```

#### systemd-boot
If you're going for a minimalistic but still quite capable setup, [`systemd-boot`](https://wiki.archlinux.org/title/systemd-boot) is essentially the best option. No extra dependencies, no rebuilding, no massive configuration files.

Install systemd-boot:
```bash
bootctl --path=/boot install
```

Create a boot configuration file at `/boot/loader/entries/arch.conf` - customize the file name however you want to. You should read the [adding loaders](https://wiki.archlinux.org/title/systemd-boot#Adding_loaders) section in the Arch wiki if you're unfamiliar with systemd loader files & kernel options.
```
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options cryptdevice=UUID=<UUID-OF-ROOT-PARTITION>:luks:allow-discards root=/dev/mapper/luks rootflags=subvol=@ rd.luks.options=discard rw
```

The options I've used above are for the LUKS + Btrfs setup - the order here is also important. Where the UUID of the partition can be obtained using
```bash
blkid -s UUID -o value /dev/sda2
```
and even directly forwarded to the loader file using (useful when you can't copy & paste
```bash
blkid -s UUID -o value /dev/sda2 >> /boot/loader/entries/arch.conf
```

Here are a few other example setups:
##### LVM setup
```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=/dev/volume/root quiet rw
```

##### LVM on LUKS setup
```
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID={UUID}:cryptlvm root=/dev/volume/root quiet rw
```

Also don't forget to add another line for the Intel [microcode](https://wiki.archlinux.org/title/Microcode) (under *linux*) if you're running an Intel CPU.
```
initrd  /intel-ucode.img
```

As the final step, edit the `/boot/loader/loader.conf` and reference your newly created loader configuration.
```
default				arch.conf
timeout				4
console-mode	max
editor					no
```

#### grub
[Grub](https://wiki.archlinux.org/index.php/GRUB) is the standard [bootloader](https://wiki.archlinux.org/index.php/Arch_boot_process) due to its flexibility, customizability and [feature set](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader). It can’t be as pretty as [syslinux](https://wiki.archlinux.org/index.php/Syslinux), but sadly that one still [doesn’t support UEFI](https://bugzilla.syslinux.org/show_bug.cgi?id=17).  
You’ll first need to fetch it using `pacman`, along with `efibootmgr` to enable GRUBs support for EFI.

```bash
pacman -S grub efibootmgr
```

After that you can install it onto your system & create a configuration file for it.
*note: these are 2 lines*
```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
```

#### syslinux
As mentioned in the previous section, the [Syslinux](https://wiki.archlinux.org/index.php/Syslinux) bootloader can be a lot more visually pleasing, and in some cases actually faster than grub (and a lot easier to configure due to the [limited feature set](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader)), but it falls short in some specific cases such as UEFI. Luckily for BIOS, it is one of the best options.
```bash
pacman -S syslinux gptfdisk
syslinux-install_update -iam
```

Okay, so `syslinux-install_update` is not very smart… it often uses the wrong partition for root, I’ve got no clue why, but just in case, go ahead and manually open the config file and edit it if need be.
```bash
vim /boot/syslinux/syslinux.cfg
```

# Todos
As all good projects, this one also has a bunch of todos I currently don't have the time/mental health to document right now.
- [ ] Time adjustments for dual booting (hwclock --systohc, etc)
- [ ] How to install AUR helpers (yay/paru) + small explanation section for AUR in general
- [ ] Add partitioning sections for raw partitions, LVM, LVM on LUKS, etc
- [ ] Mention how to automate systemd updates via **[systemd-boot-pacman-hook](https://aur.archlinux.org/packages/systemd-boot-pacman-hook/)**