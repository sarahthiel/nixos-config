{ config, pkgs, ... }:

{
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.libu2f-host pkgs.yubikey-personalization ];

  environment.systemPackages = with pkgs; [
    gnupg
    yubikey-personalization
    yubikey-manager-qt
    pinentry-qt
  ];

  #programs.gnupg.agent.enable = true;
  #programs.gnupg.agent.enableSSHSupport = true;
  #programs.gnupg.agent.pinentryFlavor = "qt";
}
