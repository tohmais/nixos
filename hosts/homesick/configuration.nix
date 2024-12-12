{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e470
  ];

  networking.hostName = "homesick";

  boot = {
    loader = {
      systemd-boot.enable = true;
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  myNixOS = {
    bundles.general.enable = true;
    bundles.users.enable = true;

    home-users = {
      "callum" = {
        userConfig = ./home.nix;
      };
    };
  };

  system.stateVersion = "24.11";
}
