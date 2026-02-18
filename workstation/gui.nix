{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      bottles
      gearlever
      bazaar

      libreoffice
      electron-mail
    ];

    programs.mpv = {
      enable = true;
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
    };
  };

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
  ];
}
