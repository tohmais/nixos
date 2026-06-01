{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;

  mod = "SUPER";
  terminal = config.hm.home.sessionVariables."TERMINAL";
  ipc = "noctalia-shell ipc call";

  # hl.bind(KEY, DISPATCHER) / hl.bind(KEY, DISPATCHER, OPTIONS).
  mkBind = key: action: {_args = [key (mkLuaInline action)];};
  mkBindOpts = key: action: opts: {_args = [key (mkLuaInline action) opts];};

  # Exec-on-press bind shorthand
  exec = key: cmd: mkBind key ''hl.dsp.exec_cmd("${cmd}")'';
  execOpts = key: cmd: opts: mkBindOpts key ''hl.dsp.exec_cmd("${cmd}")'' opts;

  # Workspace binds: $mod + N → focus N; $mod + SHIFT + N → move active there.
  workspaceBinds = builtins.concatLists (builtins.genList (
      i: let
        n = i + 1;
        key = builtins.toString (n - 10 * (n / 10)); # workspace 10 → key "0"
      in [
        (mkBind "${mod} + ${key}" "hl.dsp.focus({ workspace = ${toString n} })")
        (mkBind "${mod} + SHIFT + ${key}" "hl.dsp.window.move({ workspace = ${toString n} })")
      ]
    )
    10);
in {
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
      configType = "lua";

      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [
          "DISPLAY"
          "HYPRLAND_INSTANCE_SIGNATURE"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_ID"
        ];
      };

      settings = {
        # hl.config({ ... }) — global options
        config = {
          input = {
            kb_layout = "us";
            follow_mouse = 1;
            sensitivity = 0;
            accel_profile = "flat";
            touchpad.natural_scroll = false;
          };

          general = {
            gaps_in = 5;
            gaps_out = 5;
            border_size = 2;
            col = {
              active_border = "rgb(${config.hm.lib.stylix.colors.base0E})";
              inactive_border = "rgb(${config.hm.lib.stylix.colors.base03})";
            };
            layout = "dwindle";
            allow_tearing = false;
          };

          decoration = {
            rounding = 10;
            blur.enabled = false;
            shadow.enabled = false;
          };

          animations.enabled = true;

          dwindle = {
            preserve_split = true;
          };

          misc = {
            force_default_wallpaper = 0;
            vrr = 1;
          };

          # https://github.com/ValveSoftware/gamescope/issues/1825
          # https://github.com/hyprwm/Hyprland/issues/9064
          debug.full_cm_proto = true;
        };

        # Animations: hl.curve(...) + hl.animation(...)
        curve = {
          _args = [
            "myBezier"
            {
              type = "bezier";
              points = [[0.05 0.9] [0.1 1.05]];
            }
          ];
        };

        animation = [
          {
            leaf = "windows";
            enabled = true;
            speed = 7;
            bezier = "myBezier";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 7;
            bezier = "default";
            style = "popin 80%";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 10;
            bezier = "default";
          }
          {
            leaf = "borderangle";
            enabled = true;
            speed = 8;
            bezier = "default";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 7;
            bezier = "default";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 6;
            bezier = "default";
          }
        ];

        gesture = {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        };

        env = {_args = ["WLR_DRM_NO_ATOMIC" "1"];};

        window_rule = [
          {
            match.class = "org.libretro.RetroArch";
            fullscreen = true;
          }
          {
            match.class = "simple64-gui";
            fullscreen = true;
          }
          {
            match.class = "steam_app*";
            immediate = true;
          }
          {
            match.class = "gay.vaskel.soteria";
            pin = true;
          }
          {
            name = "xwayland-video-bridge-fixes";
            match.class = "xwaylandvideobridge";
            no_initial_focus = true;
            no_focus = true;
            no_anim = true;
            no_blur = true;
            max_size = [1 1];
            opacity = 0.0;
          }
        ];

        bind =
          [
            (exec "${mod} + RETURN" terminal)
            (mkBind "${mod} + SHIFT + Q" "hl.dsp.window.close()")
            (exec "${mod} + SHIFT + E" "${ipc} sessionMenu toggle")
            (mkBind "${mod} + Space" ''hl.dsp.window.float({ action = "toggle" })'')
            (mkBind "${mod} + F" "hl.dsp.window.fullscreen()")
            (exec "${mod} + D" "${ipc} launcher toggle")
            (exec "${mod} + O" "zen")
            (exec "${mod} + SHIFT + N" "${ipc} notifications toggleHistory")

            (exec "Print" "grimblast --notify copysave output")
            (exec "CTRL + Print" "grimblast --notify copysave area")

            (mkBind "${mod} + left" ''hl.dsp.focus({ direction = "l" })'')
            (mkBind "${mod} + right" ''hl.dsp.focus({ direction = "r" })'')
            (mkBind "${mod} + up" ''hl.dsp.focus({ direction = "u" })'')
            (mkBind "${mod} + down" ''hl.dsp.focus({ direction = "d" })'')

            (mkBind "${mod} + SHIFT + left" ''hl.dsp.window.move({ direction = "l" })'')
            (mkBind "${mod} + SHIFT + right" ''hl.dsp.window.move({ direction = "r" })'')
            (mkBind "${mod} + SHIFT + up" ''hl.dsp.window.move({ direction = "u" })'')
            (mkBind "${mod} + SHIFT + down" ''hl.dsp.window.move({ direction = "d" })'')

            (mkBind "${mod} + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
            (mkBind "${mod} + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')

            (exec "XF86AudioMute" "${ipc} volume muteOutput")
            (exec "XF86AudioMicMute" "${ipc} volume muteInput")
            (exec "XF86AudioMedia" "${ipc} media playPause")
            (exec "XF86AudioPlay" "${ipc} media playPause")
            (exec "XF86AudioPrev" "${ipc} media previous")
            (exec "XF86AudioNext" "${ipc} media next")

            (execOpts "XF86AudioRaiseVolume" "${ipc} volume increase" {repeating = true;})
            (execOpts "XF86AudioLowerVolume" "${ipc} volume decrease" {repeating = true;})
            (execOpts "XF86MonBrightnessUp" "${ipc} brightness increase" {repeating = true;})
            (execOpts "XF86MonBrightnessDown" "${ipc} brightness decrease" {repeating = true;})

            (mkBindOpts "${mod} + mouse:272" "hl.dsp.window.drag()" {mouse = true;})
            (mkBindOpts "${mod} + mouse:273" "hl.dsp.window.resize()" {mouse = true;})
          ]
          ++ workspaceBinds;

        on = {
          _args = [
            "hyprland.start"
            (mkLuaInline ''
              function()
                hl.exec_cmd("hyprctl setcursor ${config.hm.stylix.cursor.name} ${toString config.hm.stylix.cursor.size}")
                hl.exec_cmd("noctalia-shell")
                hl.exec_cmd("wbg -s ${config.hm.stylix.image}")${
                lib.optionalString (config.hm.home.sessionVariables."TERMINAL" == "ghostty") ''

                  hl.exec_cmd("ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false")''
              }
              end
            '')
          ];
        };
      };

      extraConfig = ''
        pcall(require, "monitors")
        pcall(require, "workspaces")
      '';
    };

    home.packages = with pkgs; [
      grimblast
      nwg-displays
    ];
  };
}
