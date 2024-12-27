{
  pkgs,
  lib,
  inputs,
  ...
}: let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  myHomeManager = {
    bundles.general.enable = lib.mkDefault true;

    kitty.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    chromium.enable = lib.mkDefault false;
    waybar.enable = lib.mkDefault true;
    emacs.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
  };

  gtk.enable = true;

  qt.enable = true;
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";

  services.flatpak.packages = [
    "it.mijorus.gearlever"
    "com.github.tchx84.Flatseal"
  ];

  services.mpris-proxy.enable = true;

  home.packages = with pkgs; [
    vscodium

    qownnotes
    libreoffice

    pwvucontrol
    mpv

    bottles
    zed-editor
    electron-mail

    inputs.ghostty.packages.${pkgs.system}.default
  ];
}
