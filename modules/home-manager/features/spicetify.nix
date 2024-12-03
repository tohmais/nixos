{ pkgs, inputs, ...}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    # theme = spicePkgs.themes.comfy;
    # colorScheme = "catppuccin-mocha";

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
