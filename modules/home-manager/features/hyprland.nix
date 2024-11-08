{ pkgs, config, inputs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      monitor = [
        "HDMI-A-1, preferred, 0x0, auto"
        "DVI-D-1, preferred, 1920x0, auto"
        "Unknown-1, disable"
      ];
      workspace = [
        "1, monitor:HDMI-A-1, default:true"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = 0;
      };
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        layout = "dwindle";
        allow_tearing = true;
      };
      decoration = {
        rounding = 10;
        blur.enabled = false;

        drop_shadow = false;
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
      # cursor = {
      #   no_hardware_cursors = true;
      # };
      # render = {
        # explicit_sync = 0;
        # explicit_sync_kms = 0;
      # };
      windowrulev2 = [
        "fullscreen,class:(org.libretro.RetroArch)"
        "immediate, class:^(steam_app*)$"

        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];

      "$mod" = "SUPER";
      bind =
      [
        "$mod, RETURN, exec, kitty"
        "$mod SHIFT, Q, killactive"
        "$mod SHIFT, E, exec, wlogout"
        "$mod, Space, togglefloating"
        "$mod, F, fullscreen"
        "$mod, D, exec, pkill rofi || rofi -show drun"
        "$mod, O, exec, firefox"

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

      env = [
        "WLR_DRM_NO_ATOMIC,1"
      ];

      exec-once = [
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprctl setcursor ${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"
        "swww img ${config.stylix.image}"
        "waybar"
      ];


    };
  };

  home.packages = with pkgs; [
    lxqt.lxqt-policykit
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    wl-clipboard
    grim
    slurp
    swww
    wlogout
    grimblast
  ];
}
