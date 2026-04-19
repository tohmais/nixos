{
  lib,
  config,
  ...
}: {
  boot.loader.systemd-boot.enable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    prime = {
      # Bus ID of the Intel GPU.
      intelBusId = lib.mkDefault "PCI:0@0:2:0";

      # Bus ID of the NVIDIA GPU.
      nvidiaBusId = lib.mkDefault "PCI:1@0:0:0";

      reverseSync.enable = lib.mkDefault true;
    };
  };

  hardware.bumblebee.connectDisplay = true;

  # New ThinkPads have a different TrackPoint manufacturer/name.
  # See also https://certification.ubuntu.com/catalog/component/input/5313/input%3ATPPS/2ElanTrackPoint/
  hardware.trackpoint.device = "TPPS/2 Elan TrackPoint";

  # Laptop has wifi card issues. Open up to look into.
  networking.networkmanager.wifi.powersave = lib.mkDefault false;

  services.thermald.enable = lib.mkDefault true;

  networking.hostName = "raiden";

  system.stateVersion = "24.11";
}
