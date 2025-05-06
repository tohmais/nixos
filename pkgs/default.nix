# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  sptlrx = pkgs.callPackage ./sptlrx { };
  xpad-paroj = pkgs.callPakcage ./xpad { };
}