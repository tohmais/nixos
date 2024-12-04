{ pkgs, lib, inputs, ... }:
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in  {
  myHomeManager = {
    kitty.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    chromium.enable = lib.mkDefault true;
    gtk.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    emacs.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
  };

  qt.enable = true;
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";

  home.packages = with pkgs; [
    vscodium

    obs-studio
    krita
    pinta
    kdenlive
    libreoffice

    pwvucontrol
    mpv


    vesktop

    bottles
    zed-editor
    electron-mail
  ];
}
