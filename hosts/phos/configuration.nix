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

  

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";

    desktopManager = {
      xfce.enable = true;
      xterm.enable = true;
    };
  };

  myNixOS = {
    bundles.general.enable = true;
    bundles.users.enable = true;
    bundles.gaming.enable = true;

    amd.enable = true;

    home-users = {
      "callum" = {
        userConfig = ./home.nix;
      };
    };
  };

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
    "video=HDMI-A-1:1920x1080@60"
  ];

  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0" "electron-19.1.9"];

  programs.kdeconnect.enable = true;

  fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["GeistMono"];})];

  programs.thunar.plugins = with pkgs.xfce; [thunar-archive-plugin];

  system.stateVersion = "24.05"; # Did you read the comment?
}
