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

    services.swaync = {
      enable = true;
      settings = {
        control-center-margin-top = 5;
        control-center-margin-bottom = 5;
        control-center-margin-right = 5;

        notification-window-width = 400;
        image-visibility = "when-available";
        widgets = ["mpris" "volume" "dnd" "title" "notifications"];
      };

      style = ''
        .notification-background {
          padding-right:5px;
        }

        .image {
          padding-right:5px;
          border-radius:5px;
        }

      '';
    };
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NIXOS_WAYLAND = "1";
  };
}
