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
      xconf.enable = true;
    };
    
    environment.systemPackages = [
      file-roller
    ];
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };

}