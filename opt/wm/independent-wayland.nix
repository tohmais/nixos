{pkgs, ...}: {
  services.dbus.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.soteria.enable = true;

  hm = {
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    home.packages = with pkgs; [
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      wl-clipboard
      grim
      slurp
      wbg
      networkmanagerapplet
      imv
    ];
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NIXOS_WAYLAND = "1";
  };
}
