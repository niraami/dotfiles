<!-- omit in toc -->
# Table of contents

- [Pre-flight checks](#pre-flight-checks)
  - [Verify ISO signature](#verify-iso-signature)
  - [Determining boot type](#determining-boot-type)
  - [Connecting to a network (internet)](#connecting-to-a-network-internet)
    - [Setting up a wifi connection](#setting-up-a-wifi-connection)
  - [Pacman databases & mirrors](#pacman-databases--mirrors)
    - [Updating mirrorlist /w reflector](#updating-mirrorlist-w-reflector)
- [Partitioning](#partitioning)
  - [Swap file](#swap-file)
  - [Btrfs](#btrfs)
    - [Partitions](#partitions)
    - [Setup encryption (dm-crypt + LUKS)](#setup-encryption-dm-crypt--luks)
    - [Format the partitions](#format-the-partitions)
    - [Create and mount subvolumes](#create-and-mount-subvolumes)
    - [Create a swap file](#create-a-swap-file)
  - [LVM](#lvm)
  - [Raw partitions](#raw-partitions)
- [System installation](#system-installation)
  - [Pacstrap](#pacstrap)
  - [Generating an fstab file](#generating-an-fstab-file)
- [System configuration](#system-configuration)
  - [Chrooting](#chrooting)
  - [Setup pacman databases](#setup-pacman-databases)
  - [Localization](#localization)
  - [Time zone](#time-zone)
  - [Hostname](#hostname)
  - [User account setup](#user-account-setup)
  - [Custom dotfiles/configs](#custom-dotfilesconfigs)
  - [Package installation](#package-installation)
  - [Boot manager setup](#boot-manager-setup)
    - [systemd-boot](#systemd-boot)
      - [LVM setup](#lvm-setup)
      - [LVM on LUKS setup](#lvm-on-luks-setup)
    - [grub](#grub)
    - [syslinux](#syslinux)
- [Sources](#sources)
- [Todos](#todos)

# Pre-flight checks

## Verify ISO signature

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

## Determining boot type
You're either going to be booted in **UEFI** or **BIOS/CSM**, knowing this is important for 2 reasons:
- the partition layout for your bootloader & system is going to be different based on the mode
- this guide will not cover BIOS/CSM, there are intricate limitations that should be left up to wikis and in-depth guides for specific installations (IMO)

You can use `ls /sys/firmware/efi/efivars` to determine the mode. If all of the directories (`.../efi` & `.../efivars`) exist, you're in UEFI mode. Otherwise, you're in BIOS/CSM mode.  
Reboot and correct your BIOS settings / installation media if you're in the wrong mode now, in a few steps it will be too late and you'll lose all your progress if you decide to change then.

## Connecting to a network (internet)
Straight up, this will either be the simplest thing ever, or a pain in the ass.

Connecting over an ethernet patch cable should be a plug-&-play experience, setting up a wifi connection on the other hand, not so much. Luckily the Arch live installation already has all of the tools you need to connect to all standard networks (WEP, WPA2 protected).  
I also recommend going via a cable for other reasons, such as stability & speed - as you might be downloading over 2G of files.

### Setting up a wifi connection
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

## Pacman databases & mirrors
When you'll be installing packages to your new system, you'll be pulling them from the internet via what is called [mirrors](https://wiki.archlinux.org/itle/mirrors).

These are essentially package repositories that are *copies* of the master Arch repository hosted on their servers. To handle scaling, instead of deploying hundreds of servers across the world, they utilize these mirrors - which are mostly community run servers that pull data at a set interval from the master servers. 

Each Arch system has a local list of mirrors that it uses to pull packages from - it has multiples as backups. It is important to pick mirrors which are reliable & fast - where the speed likely depends on how close they are to you.  
You could do this manually, guesstimating by their names and locations, but of course, there are tools for that - [reflector](https://wiki.archlinux.org/title/reflector).

### Updating mirrorlist /w reflector
You can check your mirrorlist in `/etc/pacman.d/mirrorlist`, if the names and server locations (go by the top level domain) sound sane to you, `reflector.timer` has likely already run, benchmarked a bunch of servers and chosen the best.  
If not, or you just want to make sure anyways, you can trigger it by starting its service. This might take a few minutes.
```bash
systemctl start reflector.service
```

Depending on when you've downloaded the ISO, you might want to now also update your local databases.
```bash
pacman -Syy
```

# Partitioning
I'm going to go over a few types of partitioning schemes, but all of them *require* you to at least create a few basic partitions. The go-to tools for this are [`cfdisk`](https://man.archlinux.org/man/cfdisk.8.en) or its less GUI counterpart [`fdisk`](https://wiki.archlinux.org/index.php/Fdisk).  
They are pretty intuitive and only require a few minutes of tinkering to figure out.

In the olden days, you just set up primary partitions on your drive & setup a filesystem on each. Now, there are more, and more importantly *better* ways of doing this. The list goes from the most bleeding-edge and feature rich option, to the least.

## Swap file
As all partitioning schemes and filesystems can and should contain either a swap partition or a file, I'll quickly go over some sizing guides so I don't seem like I'm just throwing random numbers up in the air.

I often see a lot of questions about swap partitions & files on modern systems. The takeaway I got from reading the resources below, and my own experience, is that unless you're running some unattended production servers, a very small amount of swap (just enough to handle edge cases) is the right amount - which is about 2-4G for >= 16G of RAM.  
Sources:
- [It's FOSS - How Much Swap Should You Use in Linux?](https://itsfoss.com/swap-size/)
- [RedHat - https://www.redhat.com/en/blog/do-we-really-need-swap-modern-systems](https://www.redhat.com/en/blog/do-we-really-need-swap-modern-systems)

This is why you'll see me use 2G of swap for every partitioning scheme. I'm personally nearly exclusively running 32 gigs of RAM on my systems, as I often see utilization in the 12-20G range in my profession & hobbies. This is just enough to handle, for example a render going just over the line of the ram you expected it to use, a few too many batches while training a neural net, etc.

## Btrfs
*More information on this system [here](https://wiki.archlinux.org/title/btrfs) & [here](https://btrfs.wiki.kernel.org/index.php/Main_Page).*  
*There is also a great LUKS + Btrfs setup guide (which I essentially copied) [here](https://nerdstuff.org/posts/2020/2020-004_arch_linux_luks_btrfs_systemd-boot/)*

Btrfs has recently (in the last 3-4 years) gotten some good traction - although it's been in the Kernel for a while now, only some recent 5.x releases have added much needed stability & features.

### Partitions
Create 2 partitions, 1 for your ESP ([EFI System Partition](https://wiki.archlinux.org/title/EFI_system_partition)) and the other one for the rest of your system. Don't worry, we'll split it up into *subvolumes* later.
```bash
cfdisk
```
You'll want to perform a few steps:
- setup a GTP partition table
- create a partition of size `500M` of type `EFI System`, we'll call this `sda1`
- create a partition that will use the rest of the space on the disk, leave type as `Linux filesystem`, we'll call this `sda2`
- we're done, write to disk by selecting write and typing `yes`

*note: as I'm focusing on setups with encryption, I'll be advocating the usage of a swap file. If you're installing with encryption though, it might make more sense (and your life easier) if you also create a 2G swap partition in advance. If you do, adjust the next steps accordingly.*

### Setup encryption (dm-crypt + LUKS)
*See the [wiki](https://wiki.archlinux.org/title/Dm-crypt/Device_encryption) for more information about this encryption method.*

Here we'll setup a encryption on our root partition - this could essentially be called full-disk encryption, as all that's left unencrypted is `/boot` and `/tmp`, neither of which have many security implications for normal usage.  
With LUKS encryption, you'll have to enter a password on every system boot, just after you select your boot option from the boot manager.

***You can skip this step if you want, but physical access to your machine would allow anyone access to all of your data.***

Create an encrypted container for the root file system (you need to define a passphrase). Store it in a password manager, write it down or store it in any other way as best you can, because there **is no recovery process**. If you forget it, it's gone.  
Though it is possible to change it as root. This is because LUKS uses a [master-key scheme](https://wiki.archlinux.org/title/dm-crypt/Device_encryption#Cryptsetup_passphrases_and_keys) and doesn't use the passphrase directly to store the data.
```bash
cryptsetup luksFormat /dev/sda2
```

Create & open the container - here I create a container named `luks`, this is the standard name for it, but you can use any other name.
```bash
cryptsetup open /dev/sda2 luks
```

***From now on you'll have to replace `<root>` with either `/dev/mapper/luks` if you've chosen to encrypt the root partition, or just `/dev/sda2` if not.***

### Format the partitions
Format the EFI partition with FAT32 and give it the label EFI - you can choose any other label, it's informational only.
```bash
mkfs.vfat -F32 -n EFI /dev/sda1
```

Format the root partition with Btrfs and give it the label *root* - you can choose any other label, it's informational only.
```bash
mkfs.btrfs -L root <root>
```

### Create and mount subvolumes
Create [subvolumes](https://wiki.archlinux.org/index.php/Btrfs#Subvolumes) for root, home, opt, srv, var, [snapshots](https://wiki.archlinux.org/index.php/Btrfs#Snapshots) and the entire Btrfs file system. You can leave out any of the second-to-last 4 as seen fit (opt, srv, var, snapshots), but there is not many reasons why you should.

```bash
mount <root> /mnt
btrfs sub create /mnt/@
btrfs sub create /mnt/@home
btrfs sub create /mnt/@swap
btrfs sub create /mnt/@opt
btrfs sub create /mnt/@srv
btrfs sub create /mnt/@var
btrfs sub create /mnt/@snapshots
unmount /mnt
```

Now we want to start creating the hierarchy which our system will actually run on - which means mounting the root partition, creating folders for our subvolumes & mounting everything with the proper [options](https://man.archlinux.org/man/mount.8.en#FILESYSTEM-INDEPENDENT_MOUNT_OPTIONS).  
We'll be focusing on the Btrfs related options here. If you're interested in what each of them does, and what others there are, check out the [Btrfs mount options section](https://man.archlinux.org/man/btrfs.5#MOUNT_OPTIONS).

``` bash
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@ <root> /mnt
```
*note: all the guides I've seen use the `space_cache` option in this step, but I've always gotten an error by using it - if you're encountering the same issue, just leave it out, for some reason it's going to use it anyways, as it will appear in our `fstab` when generating it later.*

Create folders for the subvolumes.
```bash
mkdir -p /mnt/{boot,home,swap,opt,srv,var,.snapshots,btrfs}
```
Notice the dot in `.snapshots`, this is important, as is the `btrfs` folder - that is going to act as our "root" mountpoint for managing subvolumes.  
Excerpt from the [Btrfs wiki](https://btrfs.wiki.kernel.org/index.php/SysadminGuide#Description):
> The top-level subvolume (with Btrfs id 5) (which one can think of as the root of the volume) can be mounted, and the full filesystem structure will be seen at the mount point; alternatively any other subvolume can be mounted (with the mount options subvol or subvolid, for example subvol=subvol_a) and only anything below that subvolume (in the above example the subvolume subvol_b, its contents, and file file_4) will be visible at the mount point.

For example, when deleting a subvolume, you'd do `btrfs sub delete /btrfs/@<subvol>`.  
Though you can name that folder whatever you want, `btrfs` just makes sense to me.

After this, we can continue mounting the rest of our subvolumes.  
*note: Btrfs currently doesn't support [changing certain parameters](https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)#MOUNT_OPTIONS) when mounting subvolumes - notably nodatacow, nodatasum, compression are all inherited, and thus don't have to currently be specified. I left them in the way you'd want to set them up just for the sake of being verbose*
```
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@home <root> /mnt/home
mount -o noatime,nodiratime,compress=no,nodatacow,nodatasum,ssd,subvol=@swap <root> /mnt/swap
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@opt <root> /mnt/opt
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@srv <root> /mnt/srv
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@var <root> /mnt/var
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvol=@snapshots <root> /mnt/.snapshots
mount -o noatime,nodiratime,compress=zstd,space_cache,ssd,subvolid=5 <root> /mnt/btrfs

mount /dev/sda1 /mnt/boot
```

One of the options I've used above, and is totally optional, is `compress=zstd. Here is what the Arch man page on Btrfs mount options says about it:
> **compress**, **compress**=type[:level], **compress-force**, **compress-force**=type[:level]
>
> (default: off, level support since: 5.1)
>
> Control BTRFS file data compression. Type may be specified as zlib, lzo, zstd or no (for no compression, used for remounting). If no type is specified, zlib is used. If compress-force is specified, then compression will always be attempted, but the data may end up uncompressed if the compression would make them larger.
>
> Both zlib and zstd (since version 5.1) expose the compression level as a tunable knob with higher levels trading speed and memory (zstd) for higher compression ratios. This can be set by appending a colon and the desired level. Zlib accepts the range [1, 9] and zstd accepts [1, 15]. If no level is set, both currently use a default level of 3. The value 0 is an alias for the default level.
>
> Otherwise some simple heuristics are applied to detect an incompressible file. If the first blocks written to a file are not compressible, the whole file is permanently marked to skip compression. As this is too simple, the compress-force is a workaround that will compress most of the files at the cost of some wasted CPU cycles on failed attempts. Since kernel 4.15, a set of heuristic algorithms have been improved by using frequency sampling, repeated pattern detection and Shannon entropy calculation to avoid that.
>
> **Note**  
> If compression is enabled, nodatacow and nodatasum are disabled.

I'm mentioning this, because it has some performance implications for slow CPUs or really fast (like PCIe 4.0 NVMe fast) drives, where you might not want to use it. Here are some cool resources that give some insight into the performance implications of various algorithms, compression levels, etc - take them with a grain of salt though, as most of them utilize RAM disks, which is far from a real-world scenario, as such, they don't take into account potential performance increases when using hard drives or SATA SSDs, where the compression speed on modern CPUs far exceeds the write speed of those disks.

Look into these sources if you've got more questions:
- [Btrfs Zstd Compression Benchmarks On Linux 4.14](https://www.phoronix.com/scan.php?page=article&item=btrfs-zstd-compress)
- [My benchmarks of BTRFS' new ZSTD levels in Linux 5.1](https://www.reddit.com/r/linux/comments/bppk9g/my_benchmarks_of_btrfs_new_zstd_levels_in_linux_51/)
- [Benchmark of BTRFS decompression](https://www.reddit.com/r/btrfs/comments/hyra46/benchmark_of_btrfs_decompression/)

***TL;DR: Use zstd or lzo compression, level 2 or 3 is fine (3 is the default).***
### Create a swap file
Swap files on Btrfs are a tricky thing, as there's [a lot of buts](https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)#SWAPFILE_SUPPORT). Please go through them as they're likely to affect your setup now, or in the future.

Currently, even though we marked our swap subvolume to be *without* compression, *without* CoW and *without* checksums, Btrfs will not respect it, as [these options are filesystem wide and don't apply to subvolumes](https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)#MOUNT_OPTIONS). So what we'll need to do here is apply these settings to just the swap file (which is possible, but more work).

Create the swap file.
```bash
touch /mnt/swap/swapfile
```

Make sure it's size and contents are both 0.
```bash
truncate -s 0 /mnt/swap/swapfile
```

Change the [copy-on-write attribute](https://man7.org/linux/man-pages/man1/chattr.1.html#ATTRIBUTES) of the file.
```bash
chattr +C /mnt/swap/swapfile
```

Reserve 2G of contiguous disk space for it.
```bash
fallocate -l 2G /mnt/swap/swapfile
```

Apply the correct permissions.
```bash
chmod 0600 /mnt/swap/swapfile
```

Now just format and enable it as normal.
```bash
mkswap /mnt/swap/swapfile
swapon /mnt/swap/swapfile
```

## LVM

## Raw partitions

# System installation
## Pacstrap
Description from the [Arch man pages for `pacstrap`](https://man.archlinux.org/man/pacstrap.8)
> pacstrap is designed to create a new system installation from scratch. The specified packages will be installed into a given directory after setting up some basic mountpoints. By default, the host system’s pacman signing keys and mirrorlist will be used to seed the chroot.
> If no packages are specified to be installed, the  _base_  metapackage will be installed.

This is the moment your installation... well.. actually becomes an installation.  
You can essentially install any and all packages from the [official repositories](https://wiki.archlinux.org/title/official_repositories) that you want now, but I'd recommend sticking to the most important ones. Here is the basic set of packages *that I think* most people will need:
|        Name        |                                   Purpose                                  |
|--------------------|----------------------------------------------------------------------------|
| **base**           | Minimal package set to define a basic Arch Linux installation              |
| **base-devel**     | Minimal group of developement oriented packages (make;sudo;gcc;sed... etc) |
| **linux**          | The Linux kernel and modules                                               |
| **linux-firmware** | Firmware files for Linux                                                   |

For more useful "base" packages, check out [base.csv](/.setup/packages/base.csv).

***Let's goooo***
```bash
pacstrap /mnt base base-devel linux linux-firmware
```

## Generating an fstab file
The [fstab](https://wiki.archlinux.org/title/fstab) file, is used to define how system partitions, volumes, remote partitions or other block devices should be mounted into your system.

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

# System configuration
Essentially all steps except for [chrooting](#chrooting), [user account setup](#user-account-setup), [package installation](#sackage-installation) & [boot manager setup](#boot-manager-setup) are optional, but probably should be performed in one way or another.

## Chrooting
[Chroot](https://wiki.archlinux.org/index.php/chroot) is used to essentially access a separate linux system on a disk as if you were booted into it. It has its limitations, the daemons, services, kernel modules, etc are not loaded - you can think of it as if you were accessing a system that is turned off. Cause that’s what you are doing. It is also used for jailing, but that is out of the scope for now.  
We need to use it to setup some parts of our new system. If you'd perform the next steps without it, you'd just be changing the live (temporary) system.

Arch has its own `chroot` tool, called `arch-chroot`, you can use it for the next steps to finish the installation before rebooting - it is actually necessary to install a boot manager using chroot before rebooting, so I guess you *must use it for a few installation steps before rebooting*.

```bash
arch-chroot /mnt
```

*note: type `exit` to exit from chroot*

## Setup pacman databases
Same way as in the beginning of this guide, you should check your package `mirrorlist`, update it using `reflector` and run pacman to synchronize your databases - it's not *really* necessary after a fresh pacstrap, but you learn to expect the unexpected when daily driving Linux.
```bash
pacman -Syy
```

## Localization
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

## Time zone
As we are currently in chroot, setting the [time zone](https://wiki.archlinux.org/index.php/System_time#Time_zone) cannot be done through `timedatectl`, but you have two other options.

Manually *symlink* the desired time zone from /usr/share/zoneinfo into /etc/localtime, example:
```bash
ln -s /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
```
Or use an interactive tool
```bash
tzselect
```

## Hostname
Just like on pretty much any system, you can set a custom the [hostname](https://wiki.archlinux.org/index.php/Network_configuration#Set_the_hostname) - it will get used across the whole system to refer to your device (ex.: dhcp, bluetooth, syncthing & even online services)
```bash
echo  "hostname" > /etc/hostname
```

It is also recommended, but not necessary to add matching entries to `/etc/hosts`. If the system has a permanent (static) IP address, it should be used instead of 127.0.1.1.
```
127.0.0.1 localhost
::1       localhost
127.0.1.1 hostname.localdomain	hostname
```

## User account setup
Before you reboot, you must set up your user account - by default, `root` doesn’t even have a password set, so it’s impossible to log into it. Setting the root password is still recommended though, at least so that you can recover your user account if anything happened to it (lost `sudo` access, made your home directory inaccessible, etc).

So, assign `root` a password. I recommend generating a 6-8 words long [passphrase](https://en.wikipedia.org/wiki/Passphrase) and storing it in a [password manager](https://keepassxc.org/), or any other encrypted or in-other-way secured file - you really won't need it unless something's gone very wrong.
```bash
passwd root
```

When adding your user, you can directly assign him some essential groups that are going to make your life easier later - though if you want a minimalistic & secure setup, adding them later, as you learn what you need, is also a good option.  
Here's just a few of the most common ones.

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

After you’ve got your user set up, don’t forget to setup the `/etc/sudoers` file, so you've got access to the `sudo` command.  
Most common ways are: uncommenting the wheel group, or just adding your username directly to the list, right under root with any permissions you like.
```bash
visudo
```
*note: you can find a more thorough explanation of the `sudoers` file on the [Arch wiki](https://wiki.archlinux.org/title/sudo#Using_visudo). But the file itself also has quite a few useful comments and examples ready for you.

For easy access, and if you’ve not worried that other people might get into your computer (like a notebook or a public server), I recommend adding yourself to the end of the file as follows:
```
username ALL=(ALL) NOPASSWD:ALL
```

## Custom dotfiles/configs
At this point, you should be able to `su` to your user and pull any dotfiles/configs you want from the internet to your home folder. I’d mostly focus on things that you can alter right now (without systemd or other services running), such as configuration files for `xorg` (`.xinitrc`, `.Xdefaults`, etc) and your `shell` (`.*rc`).

Or you can just clone this repository and use the `./install` script <3

## Package installation
You might want to install some packages in advance while you still have access to the internet through the installation image - especially packages related to [networking](https://wiki.archlinux.org/index.php/Network_configuration) - be it wifi or ethernet, you'll need some tools.  
These packages can range anywhere from tools like vim, git or ranger, all the way to different shells (zsh, fish) & window managers/desktop environments (xorg, i3, kde).

I recommend taking a look at my [categorized list of packages](./setup/packages) and installing at least [`tools.csv`](./setup/packages/tools.csv). As I currently still don't have a setup script written for these, you can use this one liner to install whatever package list you desire, or just install them one by one manually
```bash
yay -S $(tail -n +2 *.csv | awk -F "\"*,\"*" 'NF {print $2}')
```

If you don't want to go through that right now, you should at least install the [`NetworkManager`](https://wiki.archlinux.org/title/NetworkManager) package to handle your networking - it should handle and automate pretty much everything.

## Boot manager setup

You'll need to add extra hooks before the creation of your [initramfs](https://wiki.archlinux.org/title/Arch_boot_process#initramfs) by editing `/etc/mkinitcpio.conf` and adding one or more of these hooks depending on the setup you've chosen to go with in the [partitioning](#Partitioning) step. Or maybe none if you're working with raw partitions.

|     Name    |              Purpose                  |
|-------------|---------------------------------------|
| **encrypt** | Root encryption using dm-crypt/LUKS   |
| **btrfs**   | For btrfs as the root filesystem      |
| **lvm2**    | For root setup on top of LVM          |

After that, you have to recreate the `/boot/initramfs-*` files.
```bash
mkinitcpio -p linux
```

### systemd-boot
If you're going for a minimalistic but still quite capable setup, [`systemd-boot`](https://wiki.archlinux.org/title/systemd-boot) is essentially the best option. No extra dependencies, no rebuilding, no massive configuration files.

Install the systemd-boot files to `/boot`:
```bash
bootctl --path=/boot install
```

Create a boot configuration file at `/boot/loader/entries/arch.conf` - customize the file name however you want to. You should read the [adding loaders](https://wiki.archlinux.org/title/systemd-boot#Adding_loaders) section in the Arch wiki if you're unfamiliar with systemd loader files & kernel options.
```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options cryptdevice=UUID=<UUID-OF-ROOT-PARTITION>:<LUKS-CONTAINER-NAME>:allow-discards root=/dev/mapper/luks rootflags=subvol=@ rd.luks.options=discard=async rw
```

The options I've used above are for the [LUKS + Btrfs setup](#btrfs) - the order here is also important. Where the UUID of the partition can be obtained using
```bash
blkid -s UUID -o value /dev/sda2
```
and even directly forwarded to the loader file using (useful when you can't copy & paste)
```bash
blkid -s UUID -o value /dev/sda2 >> /boot/loader/entries/arch.conf
```

Here are a few other example setups:
#### LVM setup
```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=<root> quiet rw
```

#### LVM on LUKS setup
```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options cryptdevice=UUID={UUID}:cryptlvm root=<root> quiet rw
```

Also, if you're running an Intel CPU don't forget to install `intel-ucode` add another line for the Intel [microcode](https://wiki.archlinux.org/title/Microcode) (under *linux*).
```
initrd  /intel-ucode.img
```

As the final step, edit the `/boot/loader/loader.conf` and reference your newly created loader configuration.
```
default       arch.conf
timeout       4
console-mode  max
editor        no
```

### grub
[Grub](https://wiki.archlinux.org/index.php/GRUB) has, over time, evolved pretty much into the industry standard boot manager due to its flexibility, customizability and [feature set](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader). It can’t be as pretty as [syslinux](https://wiki.archlinux.org/index.php/Syslinux), but sadly that one still [doesn’t support UEFI](https://bugzilla.syslinux.org/show_bug.cgi?id=17).  
It was originally made with the goal of not having to "recompile" your settings after every modification, this has over time dissapeared and thus is quite a bit harder to work with manually - which is why I recommend [systemd-boot](#systemd-boot) over it.

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

### syslinux
As mentioned in the previous section, the [Syslinux](https://wiki.archlinux.org/index.php/Syslinux) bootloader can be a lot more visually pleasing, and in some cases actually faster than grub (and a lot easier to configure due to the [limited feature set](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader)), but it falls short in some specific cases such as UEFI. Luckily for BIOS, it is one of the best options.
```bash
pacman -S syslinux gptfdisk
syslinux-install_update -iam
```

Okay, so `syslinux-install_update` is not very smart… it often uses the wrong partition for root, I’ve got no clue why, but just in case, go ahead and manually open the config file and edit it if need be.
```bash
vim /boot/syslinux/syslinux.cfg
```

# Sources
I've already mentioned a pretty much all of these, but here they are in one place.
- [Arch Wiki](https://wiki.archlinux.org/) especially the [Installation guide](https://wiki.archlinux.org/title/installation_guide)
- [Installing Arch Linux with Btrfs, systemd-boot and LUKS](https://nerdstuff.org/posts/2020/2020-004_arch_linux_luks_btrfs_systemd-boot/)
- [Btrfs Wiki](https://btrfs.wiki.kernel.org/)
- [SUSE - Overview of File Systems in Linux](https://documentation.suse.com/sles/15-SP2/html/SLES-all/cha-filesystems.html#sec-filesystems-major-btrfs)
- [Reddit - Filesystem layout](https://www.reddit.com/r/btrfs/comments/k47es8/filesystem_layout/)
- [How To Linux Hard Disk Encryption With LUKS](https://www.cyberciti.biz/security/howto-linux-hard-disk-encryption-with-luks-cryptsetup-command/)

I gotta mention some tools as well, cause I love them:
- [Markdown tables generator](https://www.tablesgenerator.com/markdown_tables)
- [Online markdown editor](https://stackedit.io/app#)

# Todos
As all good projects, this one also has a bunch of todos I currently don't have the time/mental health to document right now.
- [ ] Time adjustments for dual booting (hwclock --systohc, etc)
- [ ] How to install AUR helpers (yay/paru) + small explanation section for AUR in general
- [ ] Add partitioning sections for raw partitions, LVM, LVM on LUKS, etc
- [ ] Mention how to automate systemd updates via **[systemd-boot-pacman-hook](https://aur.archlinux.org/packages/systemd-boot-pacman-hook/)**
- [ ] Extend boot manager section with more info about modifying GRUB to work with LVM, LUKS, BTRFS & add a syslinux section
