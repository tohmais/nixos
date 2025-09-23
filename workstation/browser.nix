{
  pkgs,
  inputs,
  mainUser,
  ...
}: {
  hm = {
    imports = [inputs.zen-browser.homeModules.twilight];

    programs.zen-browser = {
      enable = true;
      nativeMessagingHosts = [pkgs.firefoxpwa];
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        HttpsOnlyMode = true;
      };
      profiles."${mainUser}" = {
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

              icon = "https://nixos.org/favicon.ico";
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

              icon = "https://nixos.org/favicon.ico";
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://wiki.nixos.org/index.php?search={searchTerms}";}];
              icon = "https://nixos.org/favicon.ico";
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

    xdg.mimeApps = let
      value = let
        zen-browser = inputs.zen-browser.packages.${pkgs.system}.twilight; # or twilight
      in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (map (name: {
          inherit name value;
        }) [
          "application/x-extension-shtml"
          "application/x-extension-xhtml"
          "application/x-extension-html"
          "application/x-extension-xht"
          "application/x-extension-htm"
          "x-scheme-handler/unknown"
          "x-scheme-handler/mailto"
          "x-scheme-handler/chrome"
          "x-scheme-handler/about"
          "x-scheme-handler/https"
          "x-scheme-handler/http"
          "application/xhtml+xml"
          "application/json"
          "text/plain"
          "text/html"
        ]);
    in {
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
