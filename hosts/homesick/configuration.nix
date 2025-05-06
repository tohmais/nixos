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

  # TODO: Change back to linuxPackages_zen once https://github.com/NixOS/nixpkgs/issues/396716 is resolved.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  myNixOS = {
    isProfessional = true;

    isPrime = true;
    nvidia.enable = true;

    home-users = {
      "callum" = {
        userConfig = ./home.nix;
      };
    };
  };

  system.stateVersion = "24.11";
}
