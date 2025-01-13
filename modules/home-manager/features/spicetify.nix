{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    # theme = spicePkgs.themes.text;
    # colorScheme = "Kanagawa";

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      hidePodcasts
    ];
  };
}
