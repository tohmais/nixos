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


  myHomeManager = {
    zsh.enable = lib.mkDefault true;
    nix-alien.enable = lib.mkDefault true;
  };
  
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    wget
    neovim
    fastfetch
    
    playerctl

    nh
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixos";
  };

}
