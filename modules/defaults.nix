{ config, lib, pkgs, ... }:

{

  #networking
  networking.networkmanager.enable = true;

  networking.useDHCP = false;

  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];
  networking.firewall.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "de_DE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"

  ];


  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  services.journald.extraConfig = ''
    SystemMaxUse=200M
  '';

  nixpkgs.config = {
    allowUnfree = true;
  };


  nix = {
    buildCores = 0;
    daemonIONiceLevel = 4;
    daemonNiceLevel = 10;
    useSandbox = true;
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}

