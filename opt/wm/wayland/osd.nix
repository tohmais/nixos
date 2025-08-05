{
  pkgs,
  lib,
  ...
}: let
  swayosd-client = "${lib.getExe' pkgs.swayosd "swayosd-client"}";
  swaymsg = "${lib.getExe' pkgs.sway "swaymsg"}";
  hyprctl = "${lib.getExe' pkgs.hyprland "hyprctl"}";
  jq = "${lib.getExe pkgs.jq}";

  swayosd-wrapper = pkgs.writeShellScriptBin "swayosd-client" ''
    #!/usr/bin/env bash

    monitor="eDP-1"

    case "$XDG_SESSION_DESKTOP" in
      sway)
        monitor=$(${swaymsg} -t get_outputs | ${jq} -r '.[] | select(.focused == true).name')
        ;;
      hyprland)
        monitor=$(${hyprctl} monitors -j | ${jq} -r '.[] | select(.focused == true) | .name')
        ;;
    esac

    if [ -z "$monitor" ]; then
      monitor="eDP-1"
    fi


    exec ${swayosd-client} --monitor "$monitor" "$@"
  '';
in {
  hm = {
    services.swayosd.enable = true;
    home.packages = [swayosd-wrapper];
  };
}
