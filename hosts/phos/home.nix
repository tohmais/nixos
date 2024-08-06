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
    es-de.enable = true;
  };

  home = {
    username = "callum";
    homeDirectory = lib.mkDefault "/home/callum";
    stateVersion = "24.05";
  };
}
