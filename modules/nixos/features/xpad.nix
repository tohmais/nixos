{config, pkgs, ...}: {
  boot.extraModulePackages = [pkgs.xpad-paroj];

  boot.kernelModules = ["xpad"];
}
