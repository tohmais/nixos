# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
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
  ];

  # Bootloader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = false;
      };
      systemd-boot.enable = true;
    };
    supportedFilesystems = ["ntfs"];
  };

  networking.hostName = "phos"; # Define your hostname.

  time.hardwareClockInLocalTime = true;
  # Set up CachyOS kernel
  boot.kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-bore-lto-x86_64-v4;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  nixpkgs.config.permittedInsecurePackages = [
    #"electron-39.8.10" # bitwarden-desktop
    # "electron-38.8.4" # stoat-desktop
  ];

  # programs.zoom-us.enable = true;
  # myNixOS = {
  #   bundles.gaming.enable = true;

  #   # i WOULD enable this, if my internet at home wasn't a packet-dropping piece of shit
  #   # services.ollama.enable = true;
  #   # services.nixarr.enable = true;

  #   amd.enable = true;

  #   home-users = {
  #     "callum" = {
  #       userConfig = ./home.nix;
  #     };
  #   };
  # };

  # boot.kernelParams =
  # lib.mapAttrsToList
  # (
  #     name: m: let
  #     resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
  #     in "video=${name}:${resolution}"
  # )
  # (config.myHomeManager.monitors);

  # might or might not need this for amd, idk.
  boot.kernelParams = [
    "video=DP-2:1920x1080@75"
    "video=DP-1:2560x1440@180"
  ];

  hm.home.sessionVariables."TERMINAL" = "ghostty";

  programs.kdeconnect.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
