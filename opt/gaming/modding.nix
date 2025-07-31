{
  pkgs,
  inputs,
  ...
}: {
  hm = {
    services.flatpak = {
      packages = [
        "io.github.everestapi.Olympus"
      ];
    };

    home.packages = [
      pkgs.r2modman
      pkgs.hedgemodmanager

      inputs.balatro-mod-manager.packages.${pkgs.system}.default
    ];
  };
}
