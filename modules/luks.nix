{ config, ... }:

{
  boot.initrd.availableKernelModules = [
      "aes_x86_64"
      "aesni_intel"
      "cryptd"
    ];
}
