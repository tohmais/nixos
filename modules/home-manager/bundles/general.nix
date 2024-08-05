{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {

  nixpkgs = {
    config = {
      # allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };


  myHomeManager.gbar.enable = lib.mkDefault true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    neovim
    fastfetch


    nh
  ]

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixos";
  };

}
