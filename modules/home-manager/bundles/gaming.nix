{
  pkgs,
  lib,
  inputs,
  ...
}: {
  myHomeManager = {
    bundles.gui.enable = lib.mkDefault true;

    # use es-de appimage in conjunction
    es-de.enable = lib.mkDefault true;
  };

  services.flatpak.packages = [
    "com.fightcade.Fightcade"
    "io.github.Foldex.AdwSteamGtk"
  ];

  home.sessionVariables = {
    SDL_HINT_GAMECONTROLLER_USE_BUTTON_LABELS = 0;
  };

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

    srb2
    srb2kart

    clonehero
    yarg

    dolphin-emu
    ryujinx

    (retroarch.override {
      cores = with libretro; [
        snes9x
        genesis-plus-gx
        beetle-saturn
        parallel-n64
        melonds
        mgba
      ];
    })
  ];
}
