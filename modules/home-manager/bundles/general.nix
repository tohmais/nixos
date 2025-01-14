# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  config,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      # allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  myHomeManager = {
    zsh.enable = lib.mkDefault true;
    nix-alien.enable = lib.mkDefault true;
    nix-index.enable = lib.mkDefault true;
    bundles.monitors.enable = lib.mkDefault true;
    flatpak.enable = lib.mkDefault true;
    nvf.enable = lib.mkDefault true;
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    gh
    wget

    python3
    SDL2
    glew
    cmake
    jsoncpp

    coreutils
    gnumake
    clang
    pipx
    rustup

    p7zip

    playerctl
    pamixer
    xdg-utils
    btop
    dua

    nix-prefetch-scripts
    nixd
    alejandra
    nix-search-cli
  ];
}
