{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: {

  imports = [outputs.homeManagerModules.default];

  myHomeManager = {
    bundles.general.enable = true;
    bundles.gui.enable = true;
    bundles.gaming.enable = true;
    bundles.leisure.enable = true;
    bundles.university.enable = true;
  };
  
  home.packages = with pkgs; [
    davinci-resolve
    xarchiver
  ];

  home = {
    username = "callum";
    homeDirectory = lib.mkDefault "/home/callum";
    stateVersion = "24.05";
  };
}
