{ lib, ... }:

let
  sources = import ./nix/sources.nix;
  devenv = import sources.devenv;
  niv = import sources.niv { };

  # TODO: upgrade all these!
  pkgs-23-11 = import sources.nixpkgs2311 { };

  pkgs = import sources.nixpkgs2411 { };
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
    pkgs-unstable.devenv
    niv.niv
    pkgs-23-11.autojump
    pkgs-23-11.cachix
    pkgs.cloc
    pkgs-23-11.cmake
    pkgs-23-11.coreutils
    pkgs.drawio
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.elmPackages.elm-language-server
    pkgs.elmPackages.elm-review
    pkgs-23-11.fd
    pkgs-23-11.fontconfig
    pkgs-23-11.fswatch
    pkgs-23-11.gcc
    pkgs-23-11.gnupg
    pkgs-23-11.graphviz
    pkgs-unstable.gnuplot
    pkgs-23-11.imagemagick
    pkgs-23-11.jq
    pkgs-23-11.nerdfonts
    pkgs-23-11.neovim
    pkgs-23-11.nodejs
    pkgs-23-11.nixfmt
    pkgs-23-11.pandoc
    pkgs-23-11.python3
    pkgs-23-11.python310Packages.pygments
    pkgs-23-11.pyright
    pkgs-23-11.retry
    pkgs-23-11.ripgrep
    pkgs-23-11.rlwrap
    pkgs-23-11.shellcheck
    pkgs-23-11.silver-searcher
    pkgs-23-11.tectonic
    pkgs-23-11.texlive.combined.scheme-full
    pkgs-23-11.tree
    pkgs-23-11.watch
    pkgs.watchexec
    pkgs-23-11.wget
    pkgs-23-11.yarn
    pkgs-unstable.zellij
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
    package = pkgs-23-11.git;

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
    package = pkgs-23-11.tmux;

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
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
    };

    oh-my-zsh = {
      enable = true;
      # theme = "be_nice";
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
    ".config/kitty/themes" = { source = ./kitty/themes; };
    ".config/zed/keymap.json" = { source = ./zed/keymap.json; };
    ".config/zed/settings.json" = { source = ./zed/settings.json; };
  };
}
