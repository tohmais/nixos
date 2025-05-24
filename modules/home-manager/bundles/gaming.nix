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

  services.flatpak = {
    packages = [
      "com.fightcade.Fightcade"
      "io.github.Foldex.AdwSteamGtk"
      "io.github.hedge_dev.hedgemodmanager"
      "io.github.doukutsu_rs.doukutsu-rs"
      "io.github.everestapi.Olympus"
    ];

    overrides = {
      # See https://github.com/hedge-dev/HedgeModManager/issues/44
      # I only *really* need the unleashedrecomp one but might as well fix everything
      "io.github.hedge_dev.hedgemodmanager".Context = {
        filesystems = [
          "~/.var/app/io.github.hedge_dev.unleashedrecomp:ro"
          "~/.var/app/com.valvesoftware.Steam/.steam/steam/steamapps"
          "~/.var/app/com.heroicgameslauncher.hgl/config/heroic/GamesConfig:ro"
          "~/.var/app/com.heroicgameslauncher.hgl/config/heroic/legendaryConfig/legendary:ro"
        ];
      };
    };
  };

  # Don't need this anymore, as I have an Xbox layout controller for PC now (8BitDo Ultimate 2C).
  # This never worked, anyways.

  # home.sessionVariables = {
  # SDL_HINT_GAMECONTROLLER_USE_BUTTON_LABELS = 0;
  # };

  home.file = {
    ".local/share/ares/Shaders" = {
      # recursive = true;
      source = "${pkgs.libretro-shaders-slang}/share/libretro/shaders/shaders_slang";
    };
    ".local/share/ares/Database" = {
      # recursive = true;
      source = "${pkgs.ares}/share/ares/Database";
    };
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

    ares

    simple64

    (retroarch.withCores (
      cores: with libretro; [
        snes9x
        genesis-plus-gx
        beetle-saturn
        melonds
        mgba
      ]
    ))

    inputs.balatro-mod-manager.packages.${pkgs.system}.default
  ];
}
