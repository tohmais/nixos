{ pkgs, config, ... }: {
  services.udev.packages = [ pkgs.dolphinEmu ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  # to autoload at boot:
  boot.kernelModules = [
    "gcadapter_oc"
  ];
}
