{
  description = "tohmais' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
       url = "github:thiagokokada/nix-alien";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    gBar.url = "github:scorpion-26/gBar";

    stylix.url = "github:danth/stylix";
  };

  outputs = {  ... }@inputs:
    let
      myLib = import ./myLib/default.nix {inherit inputs;};
    in with myLib; {
      nixosConfigurations = {
        phos = mkSystem ./hosts/phos/configuration.nix;
      };

      homeConfigurations = {
        "callum@phos" = mkHome "x86_64-linux" ./hosts/phos/home.nix;
      };

      homeManagerModules.default = ./modules/home-manager;
      nixosModules.default = ./modules/nixos;
    };
}
