{pkgs, ...}: {
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    file-roller
  ];
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
