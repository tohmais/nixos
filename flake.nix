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
  };

  outputs = {  ... }@inputs:
    let
      myLib = import ./myLib/default.nix {inherit inputs;};
    in with myLib; {
      nixosConfigurations = {
        phos = mkSystem ./hosts/phos/configuration.nix;
      };
      
      nixosModules.default = ./nixosModules;
    };
}
