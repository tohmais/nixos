# Copyright (c) 2023 Yurii M
# Modified by Callum Wishart
{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles.callum = {
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
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
      };
    };
  };

  home.packages = with pkgs; [
    tor-browser
  ];
}
