{ ... }:

let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  pkgs = import sources.nixpkgs { };
  pkgs-unstable = import sources.nixpkgs-unstable {};
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
  home.stateVersion = "21.03";

  # Programs that require no additional configuration
  home.packages = [
    niv.niv
    pkgs.ag
    pkgs.autojump
    pkgs.cloc
    pkgs.coreutils
    pkgs.fd
    pkgs.fontconfig
    pkgs.jq
    pkgs.ncdu
    pkgs.nixfmt
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.tree
    pkgs.wget
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set up nix-direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNixDirenvIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.git;

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
  };

  programs.tmux = {
    enable = true;
    package = pkgs.tmux;

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
      doom  = "~/.emacs.d/bin/doom";
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
     ". ~/.nix-profile/etc/profile.d/nix.sh"
     (builtins.readFile ./zsh/tmux-integration.zsh)
    ];

    initExtra = builtins.concatStringsSep "\n" [
      "source ~/.nix-profile/share/autojump/autojump.zsh"
    ];
  };

  # symlink config files for other programs not managed by nix
  home.file = {
    ".hammerspoon" = { source = ./hammerspoon; };
    ".config/karabiner/karabiner.json" = { source = ./karabiner.json; };
    ".oh-my-zsh-custom/themes/be_nice.zsh-theme" = { source = ./zsh/be_nice.zsh-theme; };
  };
}
