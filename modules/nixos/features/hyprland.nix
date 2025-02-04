{
  inputs,
  pkgs,
  config,
  ...
}: {
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";

  services.gnome.gnome-keyring.enable = true;

  services.dbus.enable = true;

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  security.polkit.enable = true;
  # security.pam.services = builtins.mapAttrs (name: n: {
  #   enableGnomeKeyring = true;
  # }) (config.myNixOS.home-users);

  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.dconf.enable = true;
}
