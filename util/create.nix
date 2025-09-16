# Copied from https://git.atagen.co/atagen/nix/src/commit/353499a037fd01ebfa373ba3047e92083eb4bdb8/util/create.nix
# The original licence is included in the file LICENCE at the root of this project.
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
