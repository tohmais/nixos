{inputs, ...}: {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    config = {
      plugins = {
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
        };
        biggerStreamPreview.enable = true;
        clearURLs.enable = true;
        emoteCloner.enable = true;
        noReplyMention.enable = true;
        noServerEmojis = {
          enable = true;
          shownEmojis = "all";
        };
        userMessagesPronouns.enable = true;
        reviewDB.enable = true;
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
