{pkgs, inputs, ...}: {
  hm = {
    services.flatpak = {
      packages = [
        "io.github.hedge_dev.hedgemodmanager"
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

    home.packages = [
      pkgs.r2modman

      inputs.balatro-mod-manager.packages.${pkgs.system}.default
    ];
  };
}