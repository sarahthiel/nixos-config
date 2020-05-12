{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    bind
    binutils
    bridge-utils
    cryptsetup
    curl
    exa
    fd
    fzf
    gitAndTools.diff-so-fancy
    gitAndTools.git-annex
    git
    gnupg
    htop
    httpie
    iftop
    iotop
    lsof
    manpages
    mc
    mosh
    p7zip
    pciutils
    sudo
    tmux
    tree
    unrar
    unzip
    usbutils
    vim
    wget
    which
    whois
    zip
    zsh
  ];

  programs.ssh = {
    startAgent = true;
  };
}
