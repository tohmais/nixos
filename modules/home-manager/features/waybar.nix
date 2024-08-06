{ ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "HDMI-A-1"
          "DVI-D-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio/slider" "network" "battery" "clock" "tray"];


      };
    };
  };
}
