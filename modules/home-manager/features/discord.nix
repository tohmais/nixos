{inputs, ...}: {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    # userPlugins = {
    #   anammox = "github:Equicord/Equicord/bfb97040b9e939d705778461c1857ccb36883d72?dir=src/equicordplugins/anammox";
    # };
    # extraConfig = {
    #   plugins = {
    #     anammox.enable = true;
    #   };
    # };

    config = {
      plugins = {
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
        };
        betterSettings.enable = true;
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
