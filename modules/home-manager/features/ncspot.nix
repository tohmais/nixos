{
  config,
  lib,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
      notify = true;
      gapless = true;
      flip_status_indicators = true;
      shuffle = true;
      repeat = "off";

      audio_cache = true;
      audio_cache_size = 500;

      keybindings = {
        "Shift+p" = "move playing";
        "p" = "playpause";
        "Backspace" = "noop";
        "Esc" = "back";
      };

      theme = with colors; {
        secondary = lib.mkForce base04;
        title = lib.mkForce base0E;
        playing = lib.mkForce base0E;
        playing_selected = lib.mkForce base00;
        playing_bg = lib.mkForce base00;
        highlight = lib.mkForce base00;
        highlight_bg = lib.mkForce base0E;
        error = lib.mkForce base00;
        error_bg = lib.mkForce base08;
        statusbar = lib.mkForce base05;
        statusbar_progress = lib.mkForce base0E;
        statusbar_bg = lib.mkForce base00;
      };
    };
  };
}
