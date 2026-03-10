{
  inputs,
  pkgs,
  ...
}: {
  # NOTE: for discord to do screenshare with audio, the program NEEDS to output PulseAudio!
  hm = {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];

    programs.nixcord = {
      # _equicordRepo = builtins.fetchGit {
      #   url = "https://github.com/Equicord/Equicord.git";
      #   rev = "334ce7c113ab86f964d96a0fa5000d98bd29fade";
      # };
      # equicordPlugins = "${_equicordRepo}/src/equicordplugins";
      enable = true;
      discord = {
        equicord.enable = true;
        vencord.enable = false;
      };
      # userPlugins = {
      #   anammox = "${equicordPlugins}/anammox";
      #   betterQuickReact = "${equicordPlugins}/betterQuickReact";
      #   homeTyping = "${equicordPlugins}/homeTyping";
      #   # noNitroUpsell = "${equicordPlugins}/noNitroUpsell";
      # };
      # extraConfig = {
      #   plugins = {
      #     anammox.enable = true;
      #     betterQuickReact.enable = true;
      #     homeTyping.enable = true;
      #     # noNitroUpsell.enable = true;
      #   };
      # };

      config = {
        plugins = {
          anammox.enable = true; #now called declutter
          anonymiseFileNames = {
            enable = true;
            anonymiseByDefault = true;
          };
          # betterSettings.enable = true;
          biggerStreamPreview.enable = true;
          ClearURLs.enable = true;
          consoleJanitor.enable = true;
          # declutter.enable = true;
          fakeNitro = {
            enable = true;
            enableEmojiBypass = false;
            enableStickerBypass = false;
            enableStreamQualityBypass = true;
          };
          fixYoutubeEmbeds.enable = true;
          homeTyping.enable = true;
          noNitroUpsell.enable = true;
          noReplyMention.enable = true;
          noServerEmojis = {
            enable = true;
            shownEmojis = "currentServer";
          };
          openInApp.enable = true;
          showHiddenChannels.enable = true;
          showHiddenThings.enable = true;

          # i HAVE premium! i just have friends who i want to show music to.
          spotifyCrack.enable = true;
          userMessagesPronouns.enable = true;
          voiceMessages.enable = true;
          volumeBooster = {
            enable = true;
            multiplier = 4.0;
          };
          youtubeAdblock.enable = true;
        };
      };
    };

    home.packages = with pkgs; [
      revolt-desktop
    ];
  };
}
