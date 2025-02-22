{...}: {
  programs.mpv = {
    enable = true;
    config = {
      audio-channels = "stereo";
    };
  };
}