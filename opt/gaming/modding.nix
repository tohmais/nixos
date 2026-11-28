{
  pkgs,
  userPkgs,
  inputs,
  system,
  ...
}: {
  hm = {
    home.packages = with pkgs; [
      gale
      limo
      amethyst-mod-manager-unfree

      # TODO: add fluorine when available in nixpkgs
      hedgemodmanager
      lumafly
      doomrunner
      wheelwizard
      (userPkgs.duck-game-rebuilt)
      shipwright
      sm64coopdx
      (pkgs.olympus.override {
        celesteWrapper = "steam-run";
      })
    ];
  };
}
