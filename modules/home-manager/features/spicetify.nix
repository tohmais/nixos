{ pkgs, inputs, ...}: 
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Comfy;
    colorScheme = "catppuccin-mocha";

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      hidePodcasts
      lastfm
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}