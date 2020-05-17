{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth.programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    aliases = {
      la = "!git config -l | grep alias | cut -c 7-";
      diff = "diff --ignore-space-at-eol -b -w --ignore-blank-lines";
      l = "log --graph --pretty=format:'%Cred%h%Creset %C(bold blue)%an%C(reset) - %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
      cbr = "rev-parse --abbrev-ref HEAD";
      undo = "reset --soft HEAD~1";
      cleanup = "!git remote prune origin && git gc && git clean -df && git stash clear";
      forget = "!git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D";
      yolo = "!git add -A && git commit -m \"$(echo $(git rev-parse --abbrev-ref HEAD|grep -E -i -o \"([A-Z]+)-[0-9]+[^/]*$\"|grep -E -i -o \"([A-Z]+)-[0-9]+\") $(curl -s \"http://whatthecommit.com/index.txt\"))\"";
    };

    extraConfig = {
      core.editor = "vim";

      branch.autosetuprebase = "always";

      diff.mnemonicprefix = true;
      diff.renames = "copies";

      grep.extendedRegexp = true;
      grep.lineNumber = true;
    };


    ignores = [
      "*~"
      ".directory"
      ".Trash-*"
      "node_modules/"
      "[._]*.s[a-v][a-z]"
      "[._]*.sw[a-p]"
      "[._]s[a-v][a-z]"
      "[._]sw[a-p]"
      "Session.vim"
    ];

    signing = {
      gpgPath = "${pkgs.gnupg}/bin/gpg";
      key = "3692676504C44399DB2A3EF49003561425DD45E8";
      signByDefault = true;
    };


    userEmail = "s.thiel@sae.edu";
    userName = "Sebastian Thiel";
  };
}