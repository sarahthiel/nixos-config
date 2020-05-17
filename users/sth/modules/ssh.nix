{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  programs.ssh = {
    startAgent = true;
  };

  fileSystems."/home/sth/.ssh" = {
    device = "/nix/persistent/home/sth/ssh";
    fsType = "none";
    options = [ "bind" ];
  };
}