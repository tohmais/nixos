{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  ...
}: {

  imports = [outputs.homeManagerModules.default];

  myHomeManager = {
    bundles.general.enable = true;
    bundles.gui.enable = true;
    bundles.gaming.enable = true;
    bundles.leisure.enable = true;
    bundles.university.enable = true;


    monitors = {
      "DP-2" = {
        width = 1920;
        height = 1080;
        refreshRate = 75.;
        x = 0;
        y = 0;
      };
      "HDMI-A-1" = {
        width = 1920;
        height = 1080;
        refreshRate = 60.;
        x = 1920;
        y = 0;
      };
    };
  };

  home.packages = with pkgs; [
    davinci-resolve
    gnome.file-roller
  ];

  home = {
    username = "callum";
    homeDirectory = lib.mkDefault "/home/callum";
    stateVersion = "24.05";
  };
}
