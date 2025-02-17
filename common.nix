{
  config,
  pkgs,
  ...
}: let
  tfoldpkg = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/4ab8a3de296914f3b631121e9ce3884f1d34e1e5.tar.gz";
    sha256 = "095mc0mlag8m9n9zmln482a32nmbkr4aa319f2cswyfrln9j41cr";
  }) {system = "x86_64-linux";};
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.username = "cell";
  home.homeDirectory = "/home/cell";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    age
    alejandra
    angle-grinder
    asciidoctor
    ast-grep
    btop
    buildkit
    buf
    cargo-binstall
    charm-freeze
    cmake
    difftastic
    docker-compose
    du-dust
    duckdb
    duf
    erlang
    fd
    gitui
    gleam
    glibc
    glow
    gnumake
    gopls
    gops
    gotestsum
    grpcurl
    helmfile
    hexyl
    httpstat
    hurl
    hyperfine
    ibm-plex
    imhex
    jq
    jwt-cli
    just
    kind
    ko
    krew
    kubeconform
    kubectl
    (pkgs.wrapHelm pkgs.kubernetes-helm {
      plugins = [
        pkgs.kubernetes-helmPlugins.helm-diff
        pkgs.kubernetes-helmPlugins.helm-secrets
      ];
    })
    meld
    minikube
    nerd-fonts.anonymice
    nerd-fonts.aurulent-sans-mono
    nerd-fonts.blex-mono
    nerd-fonts.cousine
    nerd-fonts.droid-sans-mono
    nerd-fonts.envy-code-r
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.go-mono
    nerd-fonts.hack
    nerd-fonts.hasklug
    nerd-fonts.inconsolata
    nerd-fonts.inconsolata-go
    nerd-fonts.monoid
    nerd-fonts.sauce-code-pro
    nerd-fonts.symbols-only
    nix-index
    nodejs
    ollama
    pandoc
    panicparse
    patchelf
    pgcli
    pgweb
    postgresql_17
    procs
    protobuf
    pspg
    restic
    ripgrep
    ripgrep-all
    rustup
    shellcheck
    skaffold
    skopeo
    spacer
    sqlite
    stern
    tailspin
    #tfoldpkg.terraform
    terraform
    topgrade
    tokei
    trippy
    typst
    uv
    vale
    vivid
    yamllint
    yq-go
    ytt
    zigpkgs.master
    zig-shell-completions
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".autorestic.yml" = {
      enable = true;
      source = config/autorestic/autorestic.yml;
      target = ".autorestic.yml";
    };

    ".gnupg/gpg-agent.conf" = {
      enable = true;
      source = config/gnupg/gpg-agent.conf;
      target = ".gnupg/gpg-agent.conf";
    };

    ".p10k.zsh" = {
      enable = true;
      source = config/p10k/p10k.zsh;
      target = ".p10k.zsh";
    };

    ".terraformrc" = {
      enable = true;
      source = config/terraform/terraformrc;
      target = ".terraformrc";
    };

    ".vale.ini" = {
      enable = true;
      source = config/vale/vale.ini;
      target = ".vale.ini";
    };
  };

  xdg.configFile = {
    "gh-dash" = {
      enable = true;
      source = config/gh-dash;
      target = "gh-dash";
      recursive = true;
    };

    "ghostty/config" = {
      enable = true;
      source = config/ghostty/config;
      target = "ghostty/config";
    };

    "kitty" = {
      enable = true;
      source = config/kitty;
      target = "kitty";
      recursive = true;
    };

    "nvim" = {
      enable = true;
      source = config/nvim;
      target = "nvim";
      recursive = true;
    };

    "syncthing/config.xml" = {
      enable = true;
      source = config/syncthing/config.xml;
      target = "syncthing/config.xml";
    };

    "topgrade/topgrade.toml" = {
      enable = true;
      source = config/topgrade/topgrade.toml;
      target = "topgrade/topgrade.toml";
    };

    "vale" = {
      enable = true;
      source = config/vale;
      target = "vale";
      recursive = true;
    };
  };

  xdg.dataFile = {
    "navi" = {
      enable = true;
      source = data/navi;
      target = "navi";
      recursive = true;
    };
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = false;
      dialect = "uk";
      show_preview = true;
    };
  };

  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes";
      italic-text = "always";
      theme = "TwoDark";
    };
  };

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    config = {
      global.load_dotenv = true;
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  programs.fastfetch = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
    ];
  };

  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-dash
    ];
    settings = {
      version = 1;
      aliases = {
        co = "pr checkout";
        pl = "pr list";
        pc = "pr checks";
        pa = "pr review --approve";
        pm = "pr merge -s -d";
      };
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      cm = "checkout main";
      lg = "log --color --graph --decorate --oneline --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset'";
      sync = "!BRANCH=$(git symbolic-ref --short HEAD) && git fetch upstream && git merge --ff-only upstream/$BRANCH && git push origin $BRANCH";
      wta = "!f(){ git worktree add -b $1 ../$1; cd ../$1; }; f";
      wtr = "!f(){ git worktree remove $1 && git branch -D $1; }; f";
    };
    delta = {
      enable = false;
      options = {
        features = "decorations";
        side-by-side = true;
        syntax-theme = "Dracula";
        dark = true;
        hyperlinks = true;
        line-numbers = true;
        pager = "less";
      };
    };
    difftastic = {
      enable = true;
    };
    extraConfig = {
      branch = {
        sort = "-committerdate";
      };
      fetch = {
        prune = true;
      };
      format = {
        signoff = true;
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      rerere = {
        enabled = true;
      };
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };
    includes = [
      {
        condition = "gitdir:~/work/**";
        contents = {
          user = {
            email = "charith@cerbos.dev";
            name = "Charith Ellawala";
            signingKey = "B2F1410BDA6DFC9CB3154971E8C66880127C5E29";
          };
          commit = {
            gpgSign = true;
          };
        };
      }
    ];
    lfs.enable = true;
    signing = {
      key = "CE36ADA89FCB6D9D30F152935CEC9525A9DBF2BE";
      signByDefault = true;
    };
    userEmail = "charith@lucidelectricdreams.com";
    userName = "Charith Ellawala";
  };

  programs.go = {
    enable = true;
    goBin = ".local/bin";
    package = pkgs.go_1_24;
  };

  programs.home-manager.enable = true;

  programs.k9s.enable = true;

  programs.kubecolor = {
    enable = true;
    enableAlias = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.navi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.nnn = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    envExtra = ''
      export PATH=$PATH:$HOME/.local/bin:$HOME/.krew/bin
    '';
    autocd = true;
    cdpath = ["/home/work"];
    defaultKeymap = "emacs";
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 100000;
      size = 100000;
    };
    historySubstringSearch.enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      if test -n "$KITTY_INSTALLATION_DIR"; then
          export KITTY_SHELL_INTEGRATION="enabled"
          autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
          kitty-integration
          unfunction kitty-integration
      fi

      autoload edit-command-line
      zle -N edit-command-line
      bindkey '^x^e' edit-command-line

      function delete-branches() {
        git branch |
          grep --invert-match '\*' |
          cut -c 3- |
          fzf --multi --preview="git log {}" |
          xargs --no-run-if-empty git branch --delete --force
      }

      export LS_COLORS="''$(vivid generate one-light)"

      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
    '';
    profileExtra = ''
      export PAGER=bat
      export LESS='-F -g -i -M -R -S -w -X -z-4'
      export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock
      export DOCKER_SOCKET=/run/user/1000/podman/podman.sock
      export KIND_EXPERIMENTAL_PROVIDER=podman
      export USE_GKE_GCLOUD_AUTH_PLUGIN=True
    '';
    shellAliases = {
      cd = "z";
      cdi = "zi";
      docker = "podman";
      hm = "home-manager";
      j = "just";
      k = "kubectl";
      n = "navi";
      lst = "lsd --tree";
      top = "btop";
    };
    zplug = {
      enable = true;
      plugins = [
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        }
        {
          name = "Aloxaf/fzf-tab";
        }
        {
          name = "Freed-Wu/fzf-tab-source";
        }
        {
          name = "chisui/zsh-nix-shell";
        }
        {
          name = "zsh-users/zsh-completions";
        }
        {
          name = "zsh-users/zsh-syntax-highlighting";
          tags = [
            "defer:2"
          ];
        }
      ];
    };
  };

  services.syncthing.enable = true;
  fonts.fontconfig.enable = true;
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
}
