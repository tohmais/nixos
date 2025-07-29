let
  inputs = import ./inputs.nix;
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;
  recursivelyImport = import ./recursively-import.nix {inherit lib;};
  recursivePkgs = import ./recursive-pkgs.nix {inherit lib;};
in {
  systems = definitions:
    lib.mapAttrs (
      name: info: let
        system = info.system;
      in
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            userPkgs = recursivePkgs ../pkgs;
            unstablePkgs = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            mainUser = info.user;
          };
          modules =
            [
              inputs.home-manager.nixosModules.home-manager
              (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" info.user])
            ]
            ++ (recursivelyImport info.imports);
        }
    )
    definitions;
}
