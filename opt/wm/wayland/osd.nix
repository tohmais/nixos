{
  pkgs,
  lib,
  ...
}: let
  _swayosd-client = "${lib.getExe' pkgs.swayosd "swayosd-client"}";
  swaymsg = "${lib.getExe' pkgs.sway "swaymsg"}";
  hyprctl = "${lib.getExe' pkgs.hyprland "hyprctl"}";
  jq = "${lib.getExe pkgs.jq}";

  swayosd-client = pkgs.writeShellScriptBin "swayosd-client" ''
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


    exec ${_swayosd-client} --monitor "$monitor" "$@"
  '';
  swayosd-wrapped = pkgs.symlinkJoin {
    name = "swayosd-with-wrapper";
    paths = [pkgs.swayosd];
    buildInputs = [pkgs.makeWrapper];

    postBuild = ''
      rm -f $out/bin/swayosd-client
      cp ${lib.getExe swayosd-client} $out/bin/
    '';
  };
in {
  hm = {
    services.swayosd = {
      enable = true;
      package = swayosd-wrapped;
    };
  };
}
