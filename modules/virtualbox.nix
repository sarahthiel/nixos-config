{ config, lib, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;

  environment.systemPackages = with pkgs; [
    vagrant
  ];

  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.host.enableHardening = true;

  services.nfs.server.enable = true;
  #networking.firewall.allowedTCPPorts = [ 111 2049 20048 ];
  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 111 -j ACCEPT
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 20048 -j ACCEPT
  '';
  environment.etc.hosts.mode = "0644";

}
