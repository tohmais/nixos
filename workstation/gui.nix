{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      bazaar

      bitwarden-desktop
      libreoffice
      electron-mail
      optipng # for mpv
    ];
    services.flatpak.packages = [
      "it.mijorus.gearlever"
      "com.usebottles.bottles"
    ];
    programs.mpv = {
      enable = true;
      /*
         config = {
        # NOTE: if you want mpv discord screensharing, you NEED pulseaudio!
        # i'd recommend making a entry in thunar to switch between the two.
        profile = "gpu-hq";
        vo = "gpu-next";
        hwdec = "auto-copy";
        gpu-api = "vulkan";
        video-sync = "display-resample";
        interpolation = "yes";
        target-colorspace-hint = "yes";
        hdr-reference-white = 150;
      };
      */
    };
    xdg.configFile = {
      "mpv" = {
        source = builtins.fetchGit {
          url = "https://github.com/JySzE/SoM-MPV-Config.git";
          ref = "main-linux-wip";
          rev = "b7b61c2d24fd8379418108f20d72c9ad7fb1f17d";
        };
        recursive = true;
      };
    };
  };
  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    noto-fonts-cjk-sans
  ];
}
