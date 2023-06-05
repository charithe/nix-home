{ config, pkgs, ... }:

{
  home.username = "cell";
  home.homeDirectory = "/home/cell";
  home.stateVersion = "22.11"; # Please read the comment before changing.
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
    asciidoctor
    btop
    buf
    du-dust
    duf
    fd
    gcc
    gitui
    glow
    gopls
    gops
    gotestsum
    grpcurl
    helmfile
    hurl
    hyperfine
    ibm-plex
    jq
    jwt-cli
    just
    kind
    ko
    krew
    kubeconform
    kubectl
    (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [
      pkgs.kubernetes-helmPlugins.helm-diff
      pkgs.kubernetes-helmPlugins.helm-secrets
    ]; })
    gnumake
    minikube
    nerdfonts
    nodejs
    pandoc
    pgcli
    pgweb
    postgresql
    restic
    ripgrep
    rustup
    shellcheck
    skaffold
    sqlite
    stern
    terraform
    vale
    vivid
    yamllint
    yq
    ytt
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

    ".vale.ini" = {
      enable = true;
      source = config/vale/vale.ini;
      target = ".vale.ini";
    };
  };


  xdg.configFile = {
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

  home.sessionVariables = {
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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    config = {
      global.load_dotenv = true;
    };
  };

  programs.exa = {
    enable = true;
    enableAliases = false;
    git = true;
    icons = true;
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
      aliases = {
        co = "pr checkout";
        pl = "pr list";
      };
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      cm = "checkout main";
      lg = "log --color --graph --decorate --oneline --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset'";
      sync =  "!BRANCH=$(git symbolic-ref --short HEAD) && git fetch upstream && git merge --ff-only upstream/$BRANCH && git push origin $BRANCH";
    };
    delta = {
      enable = true;
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
    extraConfig = {
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
        "git@github.com:" = {
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
  };

  programs.home-manager.enable = true;

  programs.k9s.enable = true;

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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
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

      function delete-branches() {
        git branch |
          grep --invert-match '\*' |
          cut -c 3- |
          fzf --multi --preview="git log {}" |
          xargs --no-run-if-empty git branch --delete --force
      }

      export LS_COLORS="''$(vivid generate one-light)"

      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
      zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
    '';
    profileExtra = ''
      export PAGER=bat
      export LESS='-F -g -i -M -R -S -w -X -z-4'
      export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock
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
