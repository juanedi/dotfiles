{ config, pkgs, ... }:

let
  pkgs-stable = import <nixpkgs-stable> {};
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
    pkgs.ag
    pkgs.autojump
    pkgs.fzf
    pkgs.ncdu
    pkgs.tree
    pkgs.wget
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set up nix-direnv
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  # Other programs with more lengthy configuration
  imports = [
    ./programs/tmux.nix
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;

    package = pkgs-stable.git;

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
}
