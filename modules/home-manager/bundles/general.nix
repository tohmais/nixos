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
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    gh
    wget
    neovim

    coreutils
    gnumake
    clang
    pipx

    p7zip

    fastfetch
    playerctl
    pamixer
    xdg-utils
    btop
    dua

    nix-prefetch-scripts
    nixd
    alejandra

    nh
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixos";
  };

}
