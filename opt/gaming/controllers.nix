{
  pkgs,
  config,
  userPkgs,
  ...
}: {
  services.udev.packages = [pkgs.dolphin-emu];

  boot = {
    blacklistedKernelModules = ["xpad"];
    extraModulePackages = [
      # TODO: fix when https://github.com/NixOS/nixpkgs/issues/575192 gets fixed
      # config.boot.kernelPackages.gcadapter-oc-kmod
      # (userPkgs.xpad-noone-upstream {
      #   kernel = config.boot.kernelPackages.kernel;
      # })
    ];
  };

  # to autoload at boot:
  boot.kernelModules = [
    "gcadapter_oc"
  ];
  hardware = {
    xpadneo.enable = true;

    xone.enable = true;

    # xone enables this by default, but this conflicts with our version of xpad-noone!
    # xpad-noone.enable = true;
  };
}
