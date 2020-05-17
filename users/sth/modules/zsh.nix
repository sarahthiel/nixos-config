{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  
  home-manager.users.sth.programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "viins";

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreSpace = true;
      share = true;
    };

    localVariables = {
      ZSH_TMUX_AUTOSTART = false;
      #ZSH_TMUX_AUTOSTART_ONCE = true;

    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "pass"
        "tmux"
        "vi-mode"
      ];
      theme = "avit";
    };

    plugins = [];

    shellAliases = {
      sudo = "sudo ";
      _ = "sudo ";

      l = "ls -lah ";
      ll = "ls -l";
      la = "ls -lah";
      sl = "ls";

      grep = "egrep --color";

      t = "tail -f";
      c = "clear";

      psg = "ps -Ao pid,user,comm | grep $1";
      random = "openssl rand -base64 48";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "cd.." = "cd ..";
      "cd..." = "cd ../..";
      "cd...." = "cd ../../..";
      "cd....." = "cd ../../../..";

      df = "df -H";
      du = "du -c -h -d1";

      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";

      #git = "hub";
      g = "git";
      ga = "git add";
      gai = "git add -i";
      gco = "git checkout";
      gcb = "git checkout -b";
      gc = "git commit -v";
      gd = "git diff";
      gf = "git fetch";
      gfa = "git fetch --all --prune";
      gm = "git merge";
      gl = "git pull";
      gp = "git push";
      gpt = "git push --tags";
      gpoat = "git push origin --all && git push origin --tags";
      grh = "git reset HEAD";
      grhh = "git reset HEAD --hard";
      gpristine = "git reset --hard && git clean -dfx";
      gst = "git status";
      gts = "git tag -s";
      gtv = "git tag | sort -V";
      gtc = "git tag -m '' ";
      gpr = "hub pull-request";
      gprm = "hub pull-request -b master";
      gprd = "hub pull-request -b develop";
      gcis = "hub ci-status -v";

      vup = "sudo -v;vagrant up";
      vsh = "vagrant ssh";
      vop = "vagrant halt";

      fd = "find . -type d -name";
      ff = "find . -type f -name";

      clr = "clear; echo Currently logged in on $TTY, as $USER in directory $PWD.";
      psmem = "ps -e -orss=,args= | sort -b -k1,1n";
      pscpu = "ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1,1n -nr";

      getip = "ip addr | awk '/inet /{print $2}' | command grep -v 127.0.0.1";
      nano = "vim";
    };


    initExtra = ''
      alias -g E='2>&1'
      alias -g EN='2>/dev/null'
      alias -g G='| grep'
      alias -g L='|less'
      alias -g N='>/dev/null'
      alias -g T='| tail'
      alias -g TF='| tail -f'

      function cdls() {
          cd $1;
          ls;
      }
      alias cd="cdls"

      cdj() {
          cd $HOME/*/*/''${1}.*
      }

      export cdj
      alias j=cdj

      # ^s -> prepend sudo
      function add_sudo() {
        BUFFER="sudo "$BUFFER
        zle end-of-line
      }

      zle -N add_sudo
      bindkey "^s" add_sudo

      function v() {
        if [ $# -eq 0 ]; then
          vim .;
        else
          vim "$@";
        fi;
      }
    '';
  };

  environment.pathsToLink = [ "/share/zsh" ];
  users.users.sth.symlinks.".zsh_history" = "/nix/persistent/home/sth/zsh_history";
}