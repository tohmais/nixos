{ config, lib, ... }: {
  programs.waybar = {
    enable = true;
    style = lib.mkAfter ''
    * {
      font-family: "${lib.strings.removeSuffix " Mono" config.stylix.fonts.monospace.name}";
    }

    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        output = [
	  "DP-2"
          "HDMI-A-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "battery" "clock" "tray"];

        pulseaudio = {
	  format = "{volume}% {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%  ";
          format-source-muted = "  ";
	  format-icons = {
            headphone = "";
	    default = ["" "" ""];
	  };
          on-click = "pwvucontrol";
	  on-click-middle = "pamixer --default-source -t";
	  on-click-right = "pamixer -t";
	  scroll-step = 10;
	};

      };
    };
  };
}
