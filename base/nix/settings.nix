{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "pipe-operator"];
      allow-import-from-derivation = false;
      auto-optimise-store = true;
    };
    optimise.automatic = true;
    package = pkgs.lixPackageSets.git.lix;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nixpkgs.config.allowUnfree = true;
}
