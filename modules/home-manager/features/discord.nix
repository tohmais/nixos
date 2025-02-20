{inputs, ...}: {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  programs.nixcord = let
    _equicordRepo = builtins.fetchGit {
      url = "https://github.com/Equicord/Equicord.git";
      rev = "bfb97040b9e939d705778461c1857ccb36883d72";
    };
    equicordPlugins = "${_equicordRepo}/src/equicordplugins";
  in {
    enable = true;
    userPlugins = {
      anammox = "${equicordPlugins}/anammox";
      betterQuickReact = "${equicordPlugins}/betterQuickReact";
      homeTyping = "${equicordPlugins}/homeTyping";
      # noNitroUpsell = "${equicordPlugins}/noNitroUpsell";
    };
    extraConfig = {
      plugins = {
        anammox.enable = true;
        betterQuickReact.enable = true;
        homeTyping.enable = true;
        # noNitroUpsell.enable = true;
      };
    };

    config = {
      plugins = {
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
        };
        # betterSettings.enable = true;
        biggerStreamPreview.enable = true;
        clearURLs.enable = true;
        noReplyMention.enable = true;
        noServerEmojis = {
          enable = true;
          shownEmojis = "currentServer";
        };
        userMessagesPronouns.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        spotifyCrack.enable = true;
        volumeBooster = {
          enable = true;
          multiplier = 4;
        };
      };
    };
  };
}
