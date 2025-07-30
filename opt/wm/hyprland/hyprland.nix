{
  config,
  lib,
  pkgs,
  ...
}: let
  mn = "\"$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')\"";
in {
  imports = [../independent-wayland.nix];

  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";

  services.gnome.gnome-keyring.enable = true;

  hm = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        source = [
          "~/.config/hypr/monitors.conf"
          "~/.config/hypr/workspaces.conf"
        ];

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad.natural_scroll = "no";
          sensitivity = 0;
          accel_profile = "flat";
        };
        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "rgb(${config.hm.lib.stylix.colors.base0E})";
          "col.inactive_border" = "rgb(${config.hm.lib.stylix.colors.base03})";

          layout = "dwindle";
          allow_tearing = false;
        };
        decoration = {
          rounding = 10;
          blur.enabled = false;

          shadow = {
            enabled = false;
          };
        };
        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };
        misc = {
          force_default_wallpaper = 0;
          vfr = true;
        };
        gestures = {
          workspace_swipe = true;
        };
        # cursor = {
        #   no_hardware_cursors = true;
        # };
        # render = {
        # explicit_sync = 0;
        # explicit_sync_kms = 0;
        # };
        windowrulev2 = [
          "fullscreen,class:(org.libretro.RetroArch)"
          "fullscreen,class:(simple64-gui)"
          "immediate, class:^(steam_app*)$"

          "opacity 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"
          "maxsize 1 1,class:^(xwaylandvideobridge)$"
          "noblur,class:^(xwaylandvideobridge)$"

          "pin,class:polkit-gnome-authentication-agent-1"
        ];

        "$mod" = "SUPER";
        bind =
          [
            "$mod, RETURN, exec, $TERMINAL"
            "$mod SHIFT, Q, killactive"
            "$mod SHIFT, E, exec, wlogout"
            "$mod, Space, togglefloating"
            "$mod, F, fullscreen"
            "$mod, D, exec, pkill fuzzel || fuzzel"
            "$mod, O, exec, firefox"
            "$mod SHIFT, N, exec, swaync-client -t -sw"

            ", Print, exec, grimblast --notify save screen"
            "CTRL, Print, exec, grimblast --notify save area"

            "$mod,left,movefocus,l"
            "$mod,right,movefocus,r"
            "$mod,up,movefocus,u"
            "$mod,down,movefocus,d"

            "$mod SHIFT,left,movewindow,l"
            "$mod SHIFT,right,movewindow,r"
            "$mod SHIFT,up,movewindow,u"
            "$mod SHIFT,down,movewindow,d"

            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"

            ",XF86AudioMute,exec,swayosd-client --monitor ${mn} --output-volume mute-toggle"
            ",XF86AudioMicMute,exec,swayosd-client --monitor ${mn} --input-volume mute-toggle"

            ",XF86AudioMedia,exec,playerctl play-pause"
            ",XF86AudioPlay,exec,playerctl play-pause"
            ",XF86AudioPrev,exec,playerctl previous"
            ",XF86AudioNext,exec,playerctl next"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        binde = [
          ",XF86AudioRaiseVolume,exec,swayosd-client --monitor ${mn} --output-volume raise"
          ",XF86AudioLowerVolume,exec,swayosd-client --monitor ${mn} --output-volume lower"
          ",XF86MonBrightnessUp,exec,swayosd-client --monitor ${mn} --brightness raise"
          ",XF86MonBrightnessDown,exec,swayosd-client --monitor ${mn} --brightness lower"
        ];
        env = [
          "WLR_DRM_NO_ATOMIC,1"
        ];

        exec-once = [
          "hyprctl setcursor ${config.hm.stylix.cursor.name} ${toString config.hm.stylix.cursor.size}"
          "nm-applet"
          "blueman-applet"
          "swaync"
          "wbg ${config.hm.stylix.image}"
          "bash -c '[ \"$TERMINAL\" = \"ghostty\" ] && ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
        ];
        exec = [
          "pkill waybar;sleep .5 && waybar"
        ];

        # https://github.com/ValveSoftware/gamescope/issues/1825
        # https://github.com/hyprwm/Hyprland/issues/9064
        debug.full_cm_proto = true;
      };
    };

    home.packages = with pkgs; [
      grimblast
      nwg-displays
      jq
    ];
  };
}
