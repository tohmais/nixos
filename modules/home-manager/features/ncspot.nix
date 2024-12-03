{...}: {
  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
      notify = true;
      gapless = true;
      flip_status_indicators = true;
      shuffle = true;
      repeat = "off";

      keybindings = {
        "Shift+p" = "move playing";
	"p" = "playpause";
	"Backspace" = "noop";
	"Esc" = "back";
      }
    };
  };
}
