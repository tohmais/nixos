{
  pkgs,
  lib,
  ...
}: {
  services.dbus.enable = true;
  security.polkit.enable = true;
  security.soteria.enable = lib.mkDefault false;

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      NIXOS_WAYLAND = "1";
    };
    systemPackages = [pkgs.gnome-keyring];
  };

  hm = {
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    home.packages = with pkgs; [
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      wl-clipboard
      grim
      slurp
      wbg
      imv
    ];
  };
}
