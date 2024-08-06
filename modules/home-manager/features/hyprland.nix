{ pkgs, ... }: {
  home.packages = with pkgs; [
    lxqt.lxqt-policykit
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    rofi-wayland
    wl-clipboard
    grim
    slurp
    
  ];
}