{
  config,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    style = lib.mkAfter ''
      * {
        font-family: "${lib.strings.removeSuffix " Mono" config.stylix.fonts.monospace.name}";
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
      #pulseaudio {
        padding: 0 10px;
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
        color: @base0C;
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
        color: @base0B;
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
        output =
          lib.mapAttrsToList
          (
            name: m: name
          )
          (lib.filterAttrs (name: m: m.enabled) config.myHomeManager.monitors);

        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["pulseaudio" "network" "battery" "clock" "tray"];

        pulseaudio = {
          format = "{volume}% {icon} {format_source} ";
          format-muted = " {format_source} ";
          format-source = " {volume}% ";
          format-source-muted = "  ";
          format-icons = {
            headphone = "";
            default = ["" "" ""];
          };
          on-click = "pwvucontrol";
          on-click-middle = "swayosd-client --input-volume mute-toggle";
          on-click-right = "swayosd-client --output-volume mute-toggle";
          on-scroll-up = "swayosd-client --output-volume +10";
          on-scroll-down = "swayosd-client --output-volume -10";
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
          on-click = "kitty -e nmtui";
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
      };
    };
  };
}
