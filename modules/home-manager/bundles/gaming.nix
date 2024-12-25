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

    # use es-de appimage in conjunction
    es-de.enable = lib.mkDefault true;
  };

  services.flatpak.packages = [
    "com.fightcade.Fightcade"
  ];

  home.packages = with pkgs; [
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
    yarg

    dolphin-emu
    ryujinx
  ];
}
