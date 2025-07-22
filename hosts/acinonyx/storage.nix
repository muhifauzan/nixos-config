{ lib, ... }:

{
  fileSystems."/" = lib.mkForce {
    device = "/dev/disk/by-partlabel/root";
    fsType = "btrfs";

    options = [
      "subvol=@"
      "defaults"
      "noatime"
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = lib.mkForce {
    device = "/dev/disk/by-partlabel/boot";
    fsType = "vfat";

    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/home" = lib.mkForce {
    device = "/dev/disk/by-partlabel/home";
    fsType = "btrfs";

    options = [
      "defaults"
      "noatime"
      "compress=zstd"
    ];
  };

  swapDevices = lib.mkForce [
    {
      device = "/dev/disk/by-partlabel/swap";

      # Highest swap priority
      priority = 32767;
    }
  ];
}

# Use 'blkid' to print the universally unique identifier for a device; this may
# be used with UUID= as a more robust way to name devices that works even if
# disks are added and removed. See fstab(5).
#
# a     b       c       d       e       f       g       h       i       j       k       l
# <file system> <mount point>   <type>  <options> <dump> <pass>
# PARTLABEL=boot  /boot           ext4    defaults,noatime 0 2
# PARTLABEL=uefi  /boot/efi       vfat    defaults,noatime 0 2
# PARTLABEL=swap  swap            swap    defaults,noatime 0 0
# PARTLABEL=root  /               btrfs   subvol=/@,defaults,noatime,compress=zstd 0 0
# PARTLABEL=root  /var/cache      btrfs   subvol=/@cache,defaults,noatime,compress=zstd 0 0
# PARTLABEL=root  /var/log        btrfs   subvol=/@log,defaults,noatime,compress=zstd 0 0
# PARTLABEL=home  /home           btrfs   subvol=/@,defaults,noatime,compress=zstd 0 0
# tmpfs           /tmp            tmpfs   defaults,noatime,mode=1777 0 0
