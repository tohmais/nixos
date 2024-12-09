{
  inputs,
  pkgs,
  config,
  ...
}: let
  pkgs-hyprland =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";

  services.gnome.gnome-keyring.enable = true;

  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  security.polkit.enable = true;
  programs.dconf.enable = true;
}
