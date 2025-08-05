{
  pkgs,
  config,
  lib,
  ...
}: let
  mn = "\"$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')\"";
in {
  services.dbus.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.soteria.enable = true;

  hm = {
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    services.swayosd = {
      enable = true;
      package = pkgs.swayosd;
    };

    home.packages = with pkgs; [
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      wl-clipboard
      grim
      slurp
      wbg
      networkmanagerapplet
      imv
    ];

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = lib.mkForce "${config.hm.stylix.fonts.monospace.name}:size=${toString config.hm.stylix.fonts.sizes.popups}";
          width = 50;
          dpi-aware = "no";
        };
      };
    };
    services.swaync = {
      enable = true;
      settings = {
        control-center-margin-top = 5;
        control-center-margin-bottom = 5;
        control-center-margin-right = 5;

        notification-window-width = 400;
        image-visibility = "when-available";
        widgets = ["mpris" "volume" "dnd" "title" "notifications"];
      };

      style = ''
        .notification-background {
          padding-right:5px;
        }

        .image {
          padding-right:5px;
          border-radius:5px;
        }

      '';
    };

    programs.waybar = {
      enable = true;
      style = lib.mkAfter ''
        * {
          font-family: "${lib.strings.removeSuffix " Mono" config.hm.stylix.fonts.monospace.name}";
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }
        tooltip {
          border: 2px solid @base0E;
          border-radius: 8px;
        }
        .modules-left,
        .modules-center,
        .modules-right {

          background: alpha(@base00, 1);
          color: @base05;
          border: 2px solid @base0E;
          border-radius: 16px 8px;
          padding: 0 4px;
        }
        .modules-center {
          margin: 2px 0 0 0;
        }

        .modules-right {
          margin: 2px 5px 0 0;
        }

        .modules-left {
          margin: 2px 0 0 5px;
        }
        #tray,
        #clock,
        #network,
        #battery,
        #pulseaudio,
        #custom-notification {
          padding: 0 10px;
        }

        #custom-notification {
          color: @base0F
        }

        #pulseaudio {
          color: @base0A;
        }

        #network {
          color: @base0C;
        }

        #clock {
          color: @base0D;
        }

        #battery {
          color: @base0B;
        }

        @keyframes blink {
            to {
                background-color: @base00;
                color: @base08;
            }
        }

        #battery.critical:not(.charging) {
            background-color: @base08;
            color: @base00;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            border-right: 2px solid @base0E;
        }

        .modules-left #workspaces button {
          color: @base05;
        }

        .modules-right > *,
        #workspaces > * {
          border-right: 2px solid @base0E;
        }


        .modules-right > *:last-child,
        #workspaces > *:last-child {
          border-right: none;
        }

        /* nullifying the shitty stuff stylix does to the workspace module */
        .modules-left #workspaces button,
        .modules-left #workspaces button.focused,
        .modules-left #workspaces button.active {
          border-top: none;
          border-bottom: none;
          border-radius: 0px;
        }


        #workspaces button:hover,
        #workspaces button.visible {
          background: rgba(0,0,0,0);
          color: @base0D;
        }
        #workspaces button.active {
          color: @base0E;
        }
        #workspaces button.urgent {
          color: @base09;
        }

        window#waybar.empty #window,
        window#waybar.empty .modules-center {
          padding: 0px;
          margin: 0px;
          border: 0px;
          background-color: transparent;
        }
      '';
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 36;
          # waybar will just disable the module if it can't find the proper protocols, so this is safe.
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = ["pulseaudio" "battery" "clock" "custom/notification" "tray"];
          # feel free to add network back between audio and battery
          "custom/notification" = {
            "tooltip" = false;
            "format" = "{icon}";
            "format-icons" = {
              "notification" = "<span foreground='red'><sup></sup></span> ";
              "none" = " ";
              "dnd-notification" = "<span foreground='red'><sup></sup></span> ";
              "dnd-none" = " ";
              "inhibited-notification" = "<span foreground='red'><sup></sup></span> ";
              "inhibited-none" = " ";
              "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span> ";
              "dnd-inhibited-none" = " ";
            };
            "return-type" = "json";
            "exec-if" = "which swaync-client";
            "exec" = "swaync-client -swb";
            "on-click" = "swaync-client -t -sw";
            "on-click-right" = "swaync-client -d -sw";
            "escape" = true;
          };
          pulseaudio = {
            format = "{volume}% {icon} {format_source} ";
            format-muted = "󰝟 {format_source} ";
            format-source = " {volume}% ";
            format-source-muted = "  ";
            format-icons = {
              headphone = "";
              default = ["" "" ""];
            };
            on-click = "pwvucontrol";
            on-click-middle = "swayosd-client --monitor ${mn} --input-volume mute-toggle";
            on-click-right = "swayosd-client --monitor ${mn} --output-volume mute-toggle";
            on-scroll-up = "swayosd-client --monitor ${mn} --output-volume +10";
            on-scroll-down = "swayosd-client --monitor ${mn} --output-volume -10";
          };
          network = {
            format = "{ifname}";
            format-wifi = "{essid} ({signalStrength}%)  ";
            format-ethernet = "{ipaddr}/{cidr}  ";
            format-disconnected = "";
            tooltip-format = "{ifname} via {gwaddr}  ";
            tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
            tooltip-format-ethernet = "{ifname} ";
            tooltip-format-disconnected = "Disconnected ⚠";
            max-length = 50;
            on-click = "$TERMINAL -e nmtui";
            on-click-right = "nm-connection-editor";
          };

          "hyprland/window" = {
            separate-outputs = true;
            max-length = 100;
          };

          clock = {
            tooltip-format = "{:%A, %d %B %Y}";
          };
          tray = {
            spacing = 5;
          };
          battery = {
            states = {
              "critical" = 15;
            };
            format = "{capacity}% {icon} ";
            format-charging = "{capacity}% 󱐋";
            format-plugged = "{capacity}%  ";
            "format-icons" = ["" "" "" "" ""];
          };
        };
      };
    };
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NIXOS_WAYLAND = "1";
  };
}
