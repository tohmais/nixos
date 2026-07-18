{
  lib,
  config,
  inputs,
  system,
  pkgs,
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

  # From https://wiki.nixos.org/wiki/Accelerated_Video_Playback:
  # "NVIDIA users with a separate iGPU should generally prefer to use their iGPU
  # for this, and therefore look to the above Intel and AMD sections instead."
  hardware.graphics.extraPackages = lib.singleton pkgs.intel-vaapi-driver;

  # New ThinkPads have a different TrackPoint manufacturer/name.
  # See also https://certification.ubuntu.com/catalog/component/input/5313/input%3ATPPS/2ElanTrackPoint/
  hardware.trackpoint.device = "TPPS/2 Elan TrackPoint";

  # Laptop has wifi card issues. Open up to look into.
  networking.networkmanager.wifi.powersave = lib.mkDefault false;

  services.thermald.enable = lib.mkDefault true;

  internal-config.thunar.enable = false;

  boot.kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-bore-lto-x86_64-v4;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10" # bitwarden-desktop
    # "electron-38.8.4" # stoat-desktop
  ];

  networking.hostName = "raiden";
  system.stateVersion = "24.11";
}
