{
  pkgs,
  lib,
  ...
}: {
  myHomeManager = {
    bundles.gui.enable = true;
    es-de.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    zoom-us

    jetbrains.idea-community-bin
    corretto21
  ];
}
