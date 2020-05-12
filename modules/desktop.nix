{ config, services, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "alt-intl";

    libinput.enable = true;
    libinput.naturalScrolling = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  environment.systemPackages = with pkgs; [
    qtstyleplugin-kvantum-qt4
    kdeApplications.dolphin-plugins
    kdeApplications.konsole
    kdeApplications.kwalletmanager
    kdeApplications.okular
    kdeApplications.spectacle
    kdeconnect

    firefox
    vivaldi
    vivaldi-widevine
    chromium
    
    thunderbird
    libreoffice

    xclip
    pass

    spotify
    signal-desktop
    nextcloud-client

    keybase
    keybase-gui
  ];

  programs.chromium = {
    enable = true;
    defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    defaultSearchProviderSuggestURL = null;
    extraOpts = {
      DownloadDirectory = "/tmp";
    };
  };

  nixpkgs.config.firefox = {
    enablePlasmaBrowserIntegration = true;
  };
  

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
