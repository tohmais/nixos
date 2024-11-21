{pkgs, lib, config, ...}: let
  sddmTheme = import ./sddm-theme.nix {inherit pkgs;};
in {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${sddmTheme}";
    settings = {
      Theme = {
        CursorTheme = config.stylix.cursor.name;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
  ];
}
