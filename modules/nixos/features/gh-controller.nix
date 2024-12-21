{config, ...}: {
  boot.extraModulePackages = [ 
    config.boot.kernelPackages.xpad
  ];

  # to autoload at boot:
  boot.kernelModules = [ 
    "xpad"
  ];
}