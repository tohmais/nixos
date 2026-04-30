{
  pkgs,
  userPkgs,
  inputs,
  ...
}: {
  hm = {
    home.packages = with pkgs; [
      r2modman
      hedgemodmanager
      lumafly
      doomrunner
      wheelwizard
      (userPkgs.duck-game-rebuilt)
      (pkgs.olympus.override {
        celesteWrapper = "steam-run";
      })
    ];
  };
}
