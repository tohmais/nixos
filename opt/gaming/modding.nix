{
  pkgs,
  inputs,
  ...
}: {
  hm = {
    home.packages = with pkgs; [
      r2modman
      hedgemodmanager
      lumafly
      doomrunner
      mono
      wheelwizard

      (pkgs.olympus.override {
        celesteWrapper = "steam-run";
      })
    ];
  };
}
