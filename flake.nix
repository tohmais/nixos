# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  description = "tohmais' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    gBar = {
      url = "github:scorpion-26/gBar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.5.1";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {...} @ inputs: let
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
    with myLib; {
      nixosConfigurations = {
        phos = mkSystem ./hosts/phos/configuration.nix;
        homesick = mkSystem ./hosts/homesick/configuration.nix;
      };

      homeConfigurations = {
        "callum@phos" = mkHome "x86_64-linux" ./hosts/phos/home.nix;
        "callum@homesick" = mkHome "x86_64-linux" ./hosts/homesick/home.nix;
      };

      homeManagerModules.default = ./modules/home-manager;
      nixosModules.default = ./modules/nixos;
    };
}
