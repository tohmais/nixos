# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  description = "tohmais' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # gBar = {
    # url = "github:scorpion-26/gBar";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-gaming.url = "github:fufexan/nix-gaming";

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # tohmutils = {
    # url = "github:tohmais/nix-utils";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixarr = {
      url = "github:rasmus-kirk/nixarr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    balatro-mod-manager = {
      url = "github:janw4ld/balatro-mod-manager/66-linux-support-upstream";
    };

    __flake-compat = {
      url = "git+https://git.lix.systems/lix-project/flake-compat.git";
      flake = false;
    };
  };

  outputs = {...} @ inputs: let
    create = import ./util/create.nix;
  in {
    nixosConfigurations = create.systems {
      phos = {
        user = "callum";
        imports = [
          ./base
          ./workstation
          ./opt/gaming
          ./hosts/phos
        ];
        system = "x86_64-linux";
      };
      homesick = {
        user = "callum";
        imports = [
          ./base
          ./workstation
          ./hosts/homesick
        ];
        system = "x86_64-linux";
      };
    };
  };
  # outputs = {...} @ inputs: let
  #   myLib = import ./myLib/default.nix {inherit inputs;};
  # in
  #   with myLib; {
  #     # Use nix build .#example to build one of the custom packages!
  #     packages = forAllSystems (import ./pkgs);
  #     overlays = import ./overlays {inherit inputs;};

  #     nixosConfigurations = {
  #       phos = mkSystem ./hosts/phos/configuration.nix;
  #       homesick = mkSystem ./hosts/homesick/configuration.nix;
  #     };

  #     homeConfigurations = {
  #       "callum@phos" = mkHome "x86_64-linux" ./hosts/phos/home.nix;
  #       "callum@homesick" = mkHome "x86_64-linux" ./hosts/homesick/home.nix;
  #     };

  #     homeManagerModules.default = ./modules/home-manager;
  #     nixosModules.default = ./modules/nixos;
  #   };
}
