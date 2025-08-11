{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      bottles
      gearlever

      libreoffice
      electron-mail
    ];
  };

  programs.mpv = {
    enable = true;
    config = {
      # NOTE: if you want mpv discord screensharing, you NEED pulseaudio!
      # i'd recommend making a entry in thunar to switch between the two.
      hwdec = "auto";
    };
  };

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
  ];
}
