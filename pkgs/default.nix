# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  sptlrx = pkgs.callPackage ./sptlrx {};
  xpad-paroj = pkgs.callPackage ./xpad-paroj {};
  catppuccin-se-icons = pkgs.callPackage ./catppuccin-se-icons {};
  kanagawa-icons = pkgs.callPackage ./kanagawa-icons {};
  tokyo-night-sddm = pkgs.callPackages ./tokyo-night-sddm {};
}
