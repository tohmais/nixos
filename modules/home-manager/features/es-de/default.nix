{ pkgs, ...}: {
   home.packages = with pkgs; [
     (pkgs.callPackage ./package.nix { })
   ];
}
