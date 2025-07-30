{
  pkgs,
  unstablePkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [pkgs.ares];

  hm = {
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

    home.packages =
      (with pkgs; [
        mangohud

        protonup
        protonup-qt
        winetricks

        r2modman
        lutris
        heroic

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
          cores:
            with libretro; [
              snes9x
              genesis-plus-gx
              beetle-saturn
              melonds
              mgba
            ]
        ))

        inputs.balatro-mod-manager.packages.${pkgs.system}.default
      ])
      ++ (with unstablePkgs; [
        rpcs3
      ]);
  };
}
