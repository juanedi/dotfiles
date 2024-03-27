{ lib, ... }:

let
  sources = import ./nix/sources.nix;
  devenv = import sources.devenv;
  niv = import sources.niv { };

  # TODO: upgrade all these!
  pkgs-21 = import sources.nixpkgs21 { };
  pkgs-21-darwin = import sources.nixpkgs21 { localSystem = "x86_64-darwin"; };
  pkgs-23-05 = import sources.nixpkgs23 { };

  pkgs = import sources.nixpkgs2311 { };
  pkgs-unstable = import sources.nixpkgs-unstable { };
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jedi";
  home.homeDirectory = "/Users/jedi";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Programs that require no additional configuration
  home.packages = [
    devenv.default
    niv.niv
    pkgs-23-05.autojump
    pkgs-23-05.cachix
    pkgs-23-05.cloc
    pkgs-23-05.coreutils
    pkgs-unstable.elmPackages.elm-language-server
    pkgs-23-05.fd
    pkgs-23-05.fontconfig
    pkgs-23-05.gcc
    pkgs-23-05.gnupg
    pkgs-23-05.graphviz
    pkgs-23-05.imagemagick
    pkgs-23-05.jq
    pkgs-23-05.ncdu
    pkgs-23-05.nerdfonts
    pkgs-23-05.nodejs
    pkgs-23-05.nixfmt
    pkgs-23-05.pandoc
    pkgs-23-05.python310Packages.pygments
    pkgs-23-05.ripgrep
    pkgs-23-05.rlwrap
    pkgs-23-05.shellcheck
    pkgs-23-05.silver-searcher
    pkgs-21.texlive.combined.scheme-full
    pkgs-23-05.tree
    pkgs-23-05.watch
    pkgs-23-05.wget
    pkgs-23-05.yarn
    pkgs-23-05.zellij
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set up nix-direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    package = pkgs-23-05.git;

    lfs.enable = true;

    aliases = {
      co = "checkout";
      st = "status";
      ci = "commit";
      br = "branch";
      f = "fetch";
      cp = "cherry-pick";
      diffs = "diff --staged";
      logr = "log --reverse";
      l1 = "log -1 -p";
      t = "mktex";
    };

    ignores = [
      "**.swp"
      "**.ignore"
      "**.ignore.*"
      ".envrc"
      ".direnv"
      ".python-version"
      ".dir-locals.el"
    ];

    extraConfig = {
      github.user = "juanedi";
    };
  };

  programs.tmux = {
    enable = true;
    package = pkgs-23-05.tmux;

    terminal = "screen-256color";
    shortcut = "f";
    baseIndex = 1;
    keyMode = "vi";
    historyLimit = 5000;
    customPaneNavigationAndResize = false;
    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      hm    = "home-manager";
      hgrep = "history | grep -i";
      be    = "bundle exec";
      trim  = "sed \"s/^ *//g;s/ *$//g\"";
      eps   = "ps aux | grep -i";
      lstcp = "lsof -i -n -P | grep TCP | grep LISTEN";
      gst   = "git status";
      doom  = "~/.config/emacs/bin/doom";
      idr   = "rlwrap idris2";
      z     = "zellij";
    };

    oh-my-zsh = {
      enable = true;
      theme = "be_nice";
      custom = "$HOME/.oh-my-zsh-custom";
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      DOOMDIR = "$HOME/.config/doom";
    };

    initExtraFirst = builtins.concatStringsSep "\n" [
     # uncomment if using a single-user nix installation
     # ". ~/.nix-profile/etc/profile.d/nix.sh"
     (builtins.readFile ./zsh/tmux-integration.zsh)
     (builtins.readFile ./zsh/zellij-integration.zsh)
     (builtins.readFile ./zsh/pdflatex-helpers.zsh)
    ];

    initExtra = builtins.readFile ./zsh/init-extra.zsh;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_state"
        "$character"
      ];
    };
  };

  # symlink config files for other programs not managed by nix
  home.file = {
    ".hammerspoon" = { source = ./hammerspoon; };
    ".config/karabiner/karabiner.json" = { source = ./karabiner.json; };
    ".oh-my-zsh-custom/themes/be_nice.zsh-theme" = { source = ./zsh/be_nice.zsh-theme; };
    ".config/kitty/kitty.conf" = { source = ./kitty.conf; };
  };
}
