{ pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      show = "drun";
      show-icons = true;
      display-drun = "Search";
    };
  };
}
