{inputs, ...}: {
  imports = [inputs.lix-module.nixosModules.default];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "pipe-operator"];
      allow-import-from-derivation = false;
      auto-optimise-store = true;
    };
    optimise.automatic = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nixpkgs.config.allowUnfree = true;
}
