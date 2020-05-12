{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.requestEncryptionCredentials = true;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/crypt/system/root@blank
    zfs rollback -r zroot/crypt/system/var@blank
    zfs rollback -r zroot/crypt/system/tmp@blank
  '';

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 12;
    monthly = 3;
  };
}

