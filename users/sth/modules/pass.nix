{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth.programs = {
    password-store.enable = true;
    browserpass.enable = true;
  };

  fileSystems."/home/sth/.local/share/password-store" = {
    device = "/nix/persistent/home/sth/pass";
    fsType = "none";
    options = [ "bind" ];
  };
}
