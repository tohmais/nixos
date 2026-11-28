{system ? builtins.currentSystem}: let
  inputs = import ./.tack;
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in rec {
  inherit pkgs inputs;

  packages = pkgs.lib.packagesFromDirectoryRecursive {
    inherit (pkgs) callPackage;
    directory = ./pkgs;
  };

  devShells =
    import ./shell.nix {inherit pkgs;}
    // {
      # a shell with all of your own packages available
      mine = pkgs.mkShell {packages = builtins.attrValues packages;};
    };
}
