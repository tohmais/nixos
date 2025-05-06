# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  config,
  lib,
  inputs,
  outputs,
  myLib,
  ...
}: let
  cfg = config.myNixOS;

  # Taking all modules in ./features and adding enables to them
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (myLib.filesIn ./bundles);

  # Taking all module services in ./services and adding services.enables to them
  services =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.services.${name}.enable = lib.mkEnableOption "enable ${name} service";
      };

      configExtension = config: (lib.mkIf cfg.services.${name}.enable config);
    })
    (myLib.filesIn ./services);

  opts = myLib.filesIn ./options;
in {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ../shared
    ]
    ++ features
    ++ bundles
    ++ services
    ++ opts;

  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;

    nixpkgs = {
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
      ];
      config.allowUnfree = true;
    };

    nix.settings.auto-optimise-store = true;
    nix.optimise.automatic = true;

    myNixOS = {
      bundles = {
        general.enable = lib.mkDefault true;
        users.enable = lib.mkDefault true;
        gui.enable = lib.mkDefault (!config.sharedOptions.isServer);
      };
    };
  };
}
