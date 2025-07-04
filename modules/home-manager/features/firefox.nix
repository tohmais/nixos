# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles."${config.home.username}" = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        ublock-origin
        sponsorblock
        firemonkey
      ];

      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "media.av1.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;

        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "extensions.pocket.enabled" = false;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.tabs.unloadOnLowMemory" = true;
      };
      search = {
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "NixOS Wiki" = {
            urls = [{template = "https://wiki.nixos.org/index.php?search={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nw"];
          };

          "Brave Search" = {
            urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
            icon = "https://brave.com/favicon.ico";
            definedAliases = ["@b"];
          };

          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
        };
        default = "Brave Search";
        order = [
          "Brave Search"
          "ddg"
          "Nix Packages"
          "Nix Options"
          "wikipedia"
        ];

        force = true;
      };
    };
  };

  home.packages = with pkgs; [
    tor-browser
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
