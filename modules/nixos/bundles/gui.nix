{
  pkgs,
  lib,
  inputs,
  ...
}: {
  myNixOS = {
    bundles.general.enable = lib.mkDefault true;

    sddm.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
    thunar.enable = lib.mkDefault true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "NerdFontsSymbolsOnly"];})
    corefonts
    dejavu_fonts
  ];

  # For nix LSP support
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
