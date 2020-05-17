{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth.programs.firefox = {
  	enable = true;
  };

  fileSystems."/home/sth/.mozilla" = {
    device = "/nix/persistent/home/sth/mozilla";
    fsType = "none";
    options = [ "bind" ];
  };  
}