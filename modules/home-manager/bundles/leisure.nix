{
  pkgs,
  lib,
  inputs,
  ...
}: let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  myHomeManager = {
    bundles.gui.enable = lib.mkDefault true;

    spicetify.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault true;
    ncspot.enable = lib.mkDefault true;
    rescrobbled.enable = lib.mkDefault true;
  };

  home.packages =
    (with pkgs; [
      cbonsai
      fastfetch
      pipes-rs
      neo

      pinta

      vesktop

      protonvpn-gui
      nicotine-plus
      picard
      ani-cli

      aria2
    ])
    ++ (with pkgs-unstable; [
      sptlrx
    ]);
}
