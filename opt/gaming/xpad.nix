{
  config,
  pkgs,
  userPkgs,
  ...
}: let
  xpad-paroj = pkgs.callPackage userPkgs.xpad-paroj {kernel = config.boot.kernelPackages.kernel;};
in {
  boot.extraModulePackages = [xpad-paroj];

  boot.kernelModules = ["xpad-paroj"];
}
