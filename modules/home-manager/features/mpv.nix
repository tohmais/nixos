{...}: {
  programs.mpv = {
    enable = true;
    config = {
      # NOTE: if you want mpv discord screensharing, you NEED pulseaudio!
      # i'd recommend making a entry in thunar to switch between the two.
      hwdec="auto";
    };
  };
}