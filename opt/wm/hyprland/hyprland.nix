{
  config,
  lib,
  pkgs,
  ...
}: {
  # When enabling this module, PLEASE enable "wayland" as well!

  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";

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
          vrr = 1;
        };
        gesture = [
          "3, horizontal, workspace"
        ];
        # cursor = {
        #   no_hardware_cursors = true;
        # };
        # render = {
        # explicit_sync = 0;
        # explicit_sync_kms = 0;
        # };
        windowrule = [
          "match:class org.libretro.RetroArch, fullscreen on"
          "match:class simple64-gui, fullscreen on"
          "match:class steam_app*, immediate on"
          "match:class gay.vaskel.soteria, pin on"
        ];

        "$mod" = "SUPER";
        "$terminal" = config.hm.home.sessionVariables."TERMINAL";
        "$ipc" = "noctalia-shell ipc call";
        bind =
          [
            "$mod, RETURN, exec, $terminal"
            "$mod SHIFT, Q, killactive"
            "$mod SHIFT, E, exec, $ipc sessionMenu toggle"
            "$mod, Space, togglefloating"
            "$mod, F, fullscreen"
            "$mod, D, exec, $ipc launcher toggle"
            "$mod, O, exec, zen"
            "$mod SHIFT, N, exec, $ipc notifications toggleHistory"

            ", Print, exec, grimblast --notify copysave output"
            "CTRL, Print, exec, grimblast --notify copysave area"

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

            ",XF86AudioMute,exec,$ipc volume muteOutput"
            ",XF86AudioMicMute,exec,$ipc volume muteInput"

            ",XF86AudioMedia,exec,$ipc media playPause"
            ",XF86AudioPlay,exec,$ipc media playPause"
            ",XF86AudioPrev,exec,$ipc media previous"
            ",XF86AudioNext,exec,$ipc media next"
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
          ",XF86AudioRaiseVolume,exec,$ipc volume increase"
          ",XF86AudioLowerVolume,exec,$ipc volume decrease"
          ",XF86MonBrightnessUp,exec,$ipc brightness increase"
          ",XF86MonBrightnessDown,exec,$ipc brightness decrease"
        ];
        env = [
          "WLR_DRM_NO_ATOMIC,1"
        ];

        exec-once =
          [
            "hyprctl setcursor ${config.hm.stylix.cursor.name} ${toString config.hm.stylix.cursor.size}"
            "noctalia-shell"
            "wbg -s ${config.hm.stylix.image}"
          ]
          ++ lib.optionals (config.hm.home.sessionVariables."TERMINAL" == "ghostty") [
            "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
          ];

        # https://github.com/ValveSoftware/gamescope/issues/1825
        # https://github.com/hyprwm/Hyprland/issues/9064
        debug.full_cm_proto = true;
      };

      extraConfig = ''
        # fix xwayland screen sharing
        windowrule {
          name = xwayland-video-bridge-fixes
          match:class = xwaylandvideobridge

          no_initial_focus = true
          no_focus = true
          no_anim = true
          no_blur = true
          max_size = 1 1
          opacity = 0.0
        }
      '';
      systemd.variables = [
        "DISPLAY"
        "HYPRLAND_INSTANCE_SIGNATURE"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
        "XDG_SESSION_ID"
      ];
    };

    home.packages = with pkgs; [
      grimblast
      nwg-displays
    ];
  };
}
