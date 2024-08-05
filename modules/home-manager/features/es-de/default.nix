{ pkgs, ...}: {
   home.packages = with pkgs; [
     (pkgs.callPackage ./package.nix { })
   ];
   nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
  ];
}
