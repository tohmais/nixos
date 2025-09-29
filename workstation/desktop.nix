{pkgs, ...}: {
  xdg.autostart.enable = true;
  xdg.portal.enable = true;

  hm = {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
      };
      autostart.enable = true;
      portal.enable = true;
    };
    home.packages = [pkgs.xdg-utils];
  };

  boot.plymouth = {
    enable = true;
    theme = "bgrt";
    logo = ../assets/nixos-white.png;
  };
}
