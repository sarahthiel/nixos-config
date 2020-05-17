{ config, services, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "alt-intl";

    libinput.enable = true;
    libinput.naturalScrolling = true;

    displayManager.lightdm.enable = true;
      desktopManager.xfce = {
        enable = true;
        thunarPlugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar_volman
        ];
        noDesktop = true;
      };
  };

  services.gvfs.enable=true;
  services.davfs2.enable=true;
  services.tlp.enable=true;

  #security.pam.services.lightdm.enable = true;

  environment.systemPackages = with pkgs; [
    wmctrl
    xorg.xrandr
    volumeicon
    xclip
    # pass
    # nextcloud-client
    #vivaldi
    #vivaldi-widevine
    #chromium
    #thunderbird
    #libreoffice
    #spotify
    #signal-desktop

    #keybase
    #keybase-gui
    #albert
    #pavucontrol
    #arc-theme
    #feh
    #gksu
    #gnome2.gnome_icon_theme
    #gnome3.adwaita-icon-theme
    #gnome3.file-roller
    #gtk-engine-murrine
    #gtk_engines
    #gvfs
    # gvfs-samba
    #i3-wk-switch
    #swaylock
    #i3status
    #kdeFrameworks.networkmanager-qt
    #networkmanagerapplet
    #notify-desktop
    #numix-cursor-theme
    #compton
    #playerctl
    #redshift
    #xdotool
    # xfce.xfce4notifyd
    #xfce.xfce4settings
    #xfce.xfce4volumed
    #mako
    #wl-clipboard
    #grim
    #xorg.xbacklight
    #xorg.xrefresh
    #xss-lock
    #rofi
    #xclip
    # wmfocus
  ];

  #programs.chromium = {
  #  enable = true;
  #  defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
  #  defaultSearchProviderSuggestURL = null;
  #  extraOpts = {
  #    DownloadDirectory = "/tmp";
  #  };
  #};

  #nixpkgs.config.firefox = {
  #  enablePlasmaBrowserIntegration = true;
  #};
  

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
