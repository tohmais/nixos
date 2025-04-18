{
  pkgs,
  config,
  ...
}: {
  services.udev.packages = [pkgs.dolphin-emu];

  boot.extraModulePackages = [
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  # to autoload at boot:
  boot.kernelModules = [
    "gcadapter_oc"
  ];
}
