{config, ...}: {
  boot.extraModulePackages =
    with config.boot.kernelPackages; [ xpad-paroj ];

  boot.kernelModules = ["xpad"];
}
