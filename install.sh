DISK=$1
USERNAME=sth

# $1 disk name
partition_disk(){
  sgdisk --clear $1
  sgdisk -a1 -n2:1M:+512M -t2:EF00 -c 0:efi $1
  sgdisk -a1 -n1:0:0 -t1:BF01 -c 0:zfs $1
}

# $1 disk name
setup_boot(){
  mkfs.vfat $1-part2
  mkdir /mnt/boot
  mount $1-part2 /mnt/boot/
}

# $1 disk name
root_on_luks(){
  cryptsetup luksFormat $1-part1
  cryptsetup luksOpen $1-part1 cryptroot

  mkfs.ext4 -L nixos /dev/mapper/cryptroot
  mount /dev/disk/by-label/nixos /mnt

  setup_boot $1
}

root_on_tmpfs(){
  cryptsetup luksFormat $1-part1
  cryptsetup luksOpen $1-part1 crypt

  mount -t tmpfs -o size=4G none /mnt

  mkdir /mnt/nix
  mkfs.ext4 -L nix /dev/mapper/crypt
  sleep 2
  mount /dev/disk/by-label/nix /mnt/nix
  
  mkdir -p /mnt/nix/persistent/{home,etc/nixos,var/log}
  mkdir -p /mnt/{home,etc/nixos,var/log}

  mount --bind /mnt/nix/persistent/home /mnt/home
  mount --bind /mnt/nix/persistent/etc/nixos /mnt/etc/nixos
  mount --bind /mnt/nix/persistent/var/log /mnt/var/log
  
  setup_boot $1
}

# $1 disk name
# $2 username
root_on_zfs(){
  # create pool
  zpool create -f -O mountpoint=none -O atime=off -O relatime=on -O compression=on -o ashift=12 -R /mnt zroot $1-part1
  zfs create -o refreservation=1G -o mountpoint=none zroot/reserved

  # encrypted fs
  zfs create -o encryption=aes-256-gcm -o keyformat=passphrase -o mountpoint=none zroot/enc

  # system
  zfs create -o mountpoint=none zroot/enc/system

  # system - filesystem root
  zfs create -o mountpoint=legacy zroot/enc/system/root
  mount -t zfs zroot/enc/system/root /mnt

  # system - var folder
  zfs create -o mountpoint=legacy -o xattr=sa -o acltype=posixacl zroot/enc/system/var
  mkdir /mnt/var
  mount -t zfs zroot/enc/system/var /mnt/var

  # system - tmp folder
  zfs create -o mountpoint=legacy -o compression=off -o sync=disabled zroot/enc/system/tmp
  mkdir /mnt/tmp
  mount -t zfs zroot/enc/system/tmp /mnt/tmp

  # local - nix storage
  zfs create -o mountpoint=none zroot/enc/local
  zfs create -o mountpoint=legacy -o relatime=off -o atime=off zroot/enc/local/nix
  mkdir /mnt/nix
  mount -t zfs zroot/enc/local/nix /mnt/nix

  # safe (important data to keep)
  zfs create -o mountpoint=none zroot/enc/safe

  # persist folder for persistent configurations
  zfs create -o mountpoint=legacy -o com.sun:auto-snapshot=true zroot/enc/safe/persist
  mkdir /mnt/persist
  mount -t zfs zroot/enc/safe/persist /mnt/persist

  # nixos config
  zfs create -o mountpoint=legacy zroot/enc/safe/persist/nixos
  mkdir -p /mnt/etc/nixos
  mount -t zfs zroot/enc/safe/persist/nixos /mnt/etc/nixos

  # user home
  zfs create -o mountpoint=legacy -o com.sun:auto-snapshot=true zroot/enc/safe/home
  mkdir /mnt/home
  mount -t zfs zroot/enc/safe/home /mnt/home

  zfs create -o mountpoint=legacy zroot/enc/safe/home/$2
  mkdir /mnt/home/$2
  mount -t zfs zroot/enc/safe/home/$2 /mnt/home/$2

  # create initial/empty snapshots
  zfs snapshot zroot/enc/system/root@blank
  zfs snapshot zroot/enc/system/var@blank
  zfs snapshot zroot/enc/system/tmp@blank

  setup_boot $1
}

partition_disk $DISK
sleep 2
#root_on_luks $DISK
root_on_tmpfs $DISK
#root_on_zfs $DISK $USERNAME
