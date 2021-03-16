{ pkgs, ... }:

let
  pkgs-stable = import <nixpkgs-stable> {};
in {
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
