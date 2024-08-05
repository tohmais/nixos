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

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixos";
  };

}
