# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  system,
  inputs,
  outputs,
  config,
  lib,
  myLib,
  ...
}: let
  cfg = config.myHomeManager;

  # Taking all modules in ./features and adding enables to them
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (myLib.filesIn ./bundles);

  opts = myLib.filesIn ./options;
in {
  imports =
    [../shared]
    ++ features
    ++ bundles
    ++ opts;

  config = {
    myHomeManager = {
      bundles.general.enable = lib.mkDefault true;
      bundles.gui.enable = lib.mkDefault (!config.sharedOptions.isServer);
    };
  };
}
