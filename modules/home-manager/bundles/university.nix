{
  pkgs,
  lib,
  ...
}: {
  myHomeManager = {
    bundles.gui.enable = true;
  };

  home.packages = with pkgs; [
    zoom-us
    jdk
  ];
}
