{ pkgs, inputs, ...}: 
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  home.packages = with pkgs; [
    spotify
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.comfy;
    colorScheme = "catppuccin-mocha"

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      hidePodcasts
      lastfm
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
      marketplace
    ];
  };
}