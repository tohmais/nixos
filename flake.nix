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

    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    gBar = {
      url = "github:scorpion-26/gBar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    stylix = {
      url = "github:tohmais/stylix/release-24.11";
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixarr = {
      url = "github:rasmus-kirk/nixarr?rev=29b7be20d4871b0ebac2db7c1691ecd3e690283f";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    balatro-mod-manager = {
      url = "github:janw4ld/balatro-mod-manager/66-linux-support-upstream";
    };
  };

  outputs = {...} @ inputs: let
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
    with myLib; {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays {inherit inputs;};

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
