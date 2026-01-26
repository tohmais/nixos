{pkgs, ...}: {
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
  };
  xdg.mime.defaultApplications."inode/directory" = "thunar.desktop";
  environment.systemPackages = with pkgs; [
    file-roller
  ];
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
