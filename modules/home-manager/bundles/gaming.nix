{ pkgs, lib, inputs, ... }:
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  myHomeManager = {
    # use es-de appimage in conjunction
    es-de.enable = lib.mkDefault true;
  };

  home.packages = (with pkgs; [
    mangohud

    protonup
    protonup-qt
    winetricks
    protontricks

    r2modman
    lutris

    prismlauncher
    xivlauncher
    srb2kart
    clonehero

    dolphin-emu
  ])

  ++

  (with pkgs-unstable; [
    ryujinx
  ]);
}
