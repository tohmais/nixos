{userPkgs, ...}: {
  boot.extraModulePackages = [userPkgs.xpad-paroj];

  boot.kernelModules = ["xpad-paroj"];
}
