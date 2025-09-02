{
  pkgs,
  inputs,
  ...
}: {
  hm = {
    home.packages = [
      pkgs.r2modman
      pkgs.hedgemodmanager
      pkgs.lumafly
      pkgs.doomrunner
      pkgs.mono
      (pkgs.olympus.override {
        celesteWrapper = "steam-run";
      })
      inputs.balatro-mod-manager.packages.${pkgs.system}.default
    ];
  };
}
