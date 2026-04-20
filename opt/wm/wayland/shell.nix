{
  inputs,
  config,
  lib,
  ...
}: {
  hm = {
    imports = [inputs.noctalia.homeModules.default];

    programs.noctalia-shell = {
      enable = true;
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
        states = {
          polkit-agent = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 2;
      };
      settings = {
        settingsVersion = 59;
        bar = {
          barType = "floating";
          position = "top";
          density = "comfortable";
          showOutline = false;
          showCapsule = false;
          # backgroundOpacity = 1;
          useSeperateOpacity = true;
          widgets = {
            left = [
              {
                colorizeDistroLogo = false;
                colorizeSystemIcon = "none";
                customIconPath = "";
                enableColorization = false;
                icon = "noctalia";
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                characterCount = 2;
                colorizeIcons = false;
                emptyColor = "secondary";
                enableScrollWheel = true;
                focusedColor = "tertiary";
                followFocusedScreen = true;
                fontWeight = "bold";
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconScale = 0.8;
                id = "Workspace";
                labelMode = "index";
                occupiedColor = "secondary";
                pillSize = 0.6;
                showApplications = true;
                showApplicationsHover = false;
                showBadge = true;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 1;
              }
              {
                compactMode = false;
                hideMode = "hidden";
                hideWhenIdle = false;
                id = "MediaMini";
                maxWidth = 145;
                panelShowAlbumArt = true;
                scrollingMode = "hover";
                showAlbumArt = true;
                showArtistFirst = true;
                showProgressRing = true;
                showVisualizer = true;
                textColor = "none";
                useFixedWidth = false;
                visualizerType = "linear";
              }
            ];
            center = [
              {
                colorizeIcons = false;
                hideMode = "hidden";
                id = "ActiveWindow";
                maxWidth = 800;
                scrollingMode = "hover";
                showIcon = true;
                showText = true;
                textColor = "none";
                useFixedWidth = false;
              }
            ];
            right = [
              {
                blacklist = [];
                chevronColor = "none";
                colorizeIcons = false;
                drawerEnabled = true;
                hidePassive = false;
                id = "Tray";
                pinned = [];
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Network";
                textColor = "none";
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Bluetooth";
                textColor = "none";
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Volume";
                middleClickCommand = "pwvucontrol || pavucontrol";
                textColor = "none";
              }
              {
                deviceNativePath = "__default__";
                displayMode = "graphic-clean";
                hideIfIdle = false;
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = false;
              }
              {
                hideWhenZero = false;
                hideWhenZeroUnread = false;
                iconColor = "none";
                id = "NotificationHistory";
                showUnreadBadge = true;
                unreadBadgeColor = "primary";
              }
              {
                clockColor = "none";
                customFont = "";
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm - dd MM";
                id = "Clock";
                tooltipFormat = "HH:mm ddd, MMM dd";
                useCustomFont = false;
              }
              {
                iconColor = "none";
                id = "SessionMenu";
              }
            ];
          };
        };
        general = {
          avatarImage = "${config.hm.home.homeDirectory}/.face";
        };
        ui = {
          fontDefault = lib.mkForce config.hm.stylix.fonts.monospace.name;
          fontFixed = lib.mkForce config.hm.stylix.fonts.monospace.name;
        };
        location = {
          weatherEnabled = false;
          autoLocate = false;
        };

        wallpaper.enabled = false;

        appLauncher = {
          enableClipboardHistory = true;
          terminalCommand = "${config.hm.home.sessionVariables."TERMINAL"} -e";
          overviewLayer = true;
        };

        controlCenter = {
          shortcuts = {
            left = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "AirplaneMode";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "KeepAwake";
              }
              {
                id = "NightLight";
              }
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "brightness-card";
            }
            {
              enabled = false;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };
        dock.dockType = "attached";
        osd.location = "bottom";
        templates.enableUserTheming = false;
      };
    };
  };
}
