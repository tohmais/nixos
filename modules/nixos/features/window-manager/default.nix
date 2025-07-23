{
  lib,
  config,
  pkgs,
  ...
}: let
  isWayland = config.sharedOptions.isWayland;
in {
  imports = [
    ./hyprland.nix
    #./river.nix
  ];
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
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        NIXOS_WAYLAND = "1";
      };

    })
    (lib.mkIf (!isWayland) {
      })
  ];
}
