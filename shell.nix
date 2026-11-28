let
  inputs = import ./.tack;
in
  {pkgs ? inputs.nixpkgs.legacyPackages.${builtins.currentSystem}}: {
    default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        nix
        nh
        home-manager
        git
        neovim
        inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  }
