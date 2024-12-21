{ config, ... }: {

  boot.extraModulePackages = [ 
    (config.boot.kernelPackages.callPackage ./xpad.nix {})
  ];

  boot.kernelModules = ["xpad"];
}