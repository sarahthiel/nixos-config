{ nixos, lib, pkgs, config, stdenv, ... }:

{
  environment.systemPackages = with pkgs; [
  	bolt
    pavucontrol
    paprefs
  ];

  # acpi
  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  # intel cpu
  boot.initrd.kernelModules = [ "i915" ];

  hardware.cpu.intel.updateMicrocode = false;  

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];

  services = {
    udev.extraRules = let
      t490ProfileSet = ./t490-profile-set.conf;
    in ''
    SUBSYSTEM!="sound", GOTO="pulseaudio_end"
    ACTION!="change", GOTO="pulseaudio_end"
    KERNEL!="card*", GOTO="pulseaudio_end"

    # Lenovo T490
    ATTRS{vendor}=="0x8086" ATTRS{device}=="0x9dc8" ATTRS{subsystem_vendor}=="0x17aa", ATTRS{subsystem_device}=="0x2279", ENV{PULSE_PROFILE_SET}="${t490ProfileSet}"

    LABEL="pulseaudio_end"
    '';
    
    throttled.enable = lib.mkDefault true;
  };  

  # tunderbolt
  services.hardware.bolt.enable = true;

  #audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.pulseaudio.package = pkgs.pulseaudioFull; # Full for bluetooth audio support.

  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia.prime.offload.enable = true;
  #hardware.nvidia.prime = {
  #  # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
  #  intelBusId = "PCI:0:2:0";
  #  # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #  nvidiaBusId = "PCI:60:0:0";
  #};

  services.fwupd.enable = true;
}
