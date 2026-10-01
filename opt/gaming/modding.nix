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
      # limo
      inputs.amethyst.packages.${system}.default
      # TODO: add fluorine and amethyst when they become available in nixpkgs
      hedgemodmanager
      lumafly
      doomrunner
      wheelwizard
      (userPkgs.duck-game-rebuilt)
      sm64coopdx
      (pkgs.olympus.override {
        celesteWrapper = "steam-run";
      })
    ];
  };
}
