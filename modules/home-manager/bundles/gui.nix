{ pkgs, lib, inputs, ... }:
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in  {
  myHomeManager = {
    gbar.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    chromium.enable = lib.mkDefault true;
    gtk.enable = lib.mkDefault true;
  };

  qt.enable = true;
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";

  home.packages = (with pkgs; [
    vscodium

    obs-studio
    krita
    pinta
    kdenlive
    libreoffice

    pwvucontrol
    mpv
    amberol

    electron-mail
    vesktop

    bottles
  ])

  ++

  (with pkgs-unstable; [
    zed-editor
  ]);
}
