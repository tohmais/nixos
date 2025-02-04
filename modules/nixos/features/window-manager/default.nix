{
  lib,
  config,
  pkgs,
  ...
}: let
  wm = config.sharedOptions.desktopEnvironment;
  isWayland = config.sharedOptions.isWayland;
in {
  imports =
    lib.optional (wm == "hyprland") ./hyprland.nix
    ++ lib.optional (wm == "river") ./river.nix;

  config = lib.mkMerge [
    {
      services.gnome.gnome-keyring.enable = true;
      security.pam.services.sddm.enableGnomeKeyring = config.myNixOS.sddm.enable;

      services.dbus.enable = true;
      security.polkit.enable = true;
      programs.dconf.enable = true;
    }
    (lib.mkIf isWayland {
      xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    })
    (lib.mkIf (!isWayland) {
      })
  ];
}
