{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnupg1
    lxc
  ];

  virtualisation.lxc = {
    # Enable LXC
    enable = true;

    # Default container configuration.
    defaultConfig = ''
      # Network interface piggy-backed from libvirt
      lxc.net.0.type = veth
      lxc.net.0.link = virbr0
      lxc.net.0.name = eth0
      lxc.net.0.flags = up

      # There's apparmor trouble with LXC.
      # (That's over my paygrade.)
      lxc.apparmor.profile = unconfined

      lxc.idmap = u 0 100000 65536
      lxc.idmap = g 0 100000 65536
    '';

    systemConfig = ''
      lxc.lxcpath = /var/lxc
    '';
  };

  users.users.root = {
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];

    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
  };

  # Piggyback on libvirt's network interface.
  virtualisation.libvirtd.enable = true;

  # Ensure the network bridge works when firewalled.
  networking = {
    firewall = {
      # Network bridge
      trustedInterfaces = [ "virbr0" "tun0" ];
      # DNS + DHCP
      allowedUDPPorts = [ 53 67 ];
    };
  };

  # Idempotently ensures the needed folders are there for LXC.
  system.activationScripts = {
    "lxc-folders" = {
      text = ''
        mkdir -p /var/cache/lxc
        mkdir -p /var/lib/lxc/rootfs
      '';
      deps = [];
    };
  };
}
