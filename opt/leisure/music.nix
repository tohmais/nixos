{
  pkgs,
  inputs,
  config,
  userPkgs,
  lib,
  ...
}: let
  colors = config.hm.lib.stylix.colors.withHashtag;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  hm = {
    imports = [inputs.spicetify-nix.homeManagerModules.default];
    programs = {
      cava = {
        enable = true;
        settings = {
          input.method = "pipewire";
          color = with colors; {
            gradient = 1;
            gradient_color_1 = "'${base0C}'";
            gradient_color_2 = "'${base0D}'";
            gradient_color_3 = "'${base0D}'";
            gradient_color_4 = "'${base0E}'";
            gradient_color_5 = "'${base0E}'";
            gradient_color_6 = "'${base0E}'";
            gradient_color_7 = "'${base08}'";
            gradient_color_8 = "'${base09}'";
          };
        };
      };
      ncspot = {
        enable = true;
        settings = {
          use_nerdfont = true;
          notify = true;
          gapless = true;
          flip_status_indicators = true;
          shuffle = true;
          repeat = "off";
          backend = "pulseaudio";

          audio_cache = true;
          audio_cache_size = 2000;

          keybindings = {
            "Shift+p" = "move playing";
            "p" = "playpause";
            "Backspace" = "noop";
            "Esc" = "back";
          };

          theme = with colors; {
            secondary = lib.mkForce base04;
            title = lib.mkForce base0E;
            playing = lib.mkForce base0E;
            playing_selected = lib.mkForce base00;
            playing_bg = lib.mkForce base00;
            highlight = lib.mkForce base00;
            highlight_bg = lib.mkForce base0E;
            error = lib.mkForce base00;
            error_bg = lib.mkForce base08;
            statusbar = lib.mkForce base05;
            statusbar_progress = lib.mkForce base0E;
            statusbar_bg = lib.mkForce base00;
          };
        };
      };
      spicetify = {
        enable = true;
        spotifyPackage = pkgs.spotify;
        # theme = spicePkgs.themes.text;
        # colorScheme = "Kanagawa";

        enabledExtensions = with spicePkgs.extensions; [
          shuffle
          hidePodcasts
        ];
      };
    };

    home.packages = [
      pkgs.rescrobbled
      (pkgs.callPackage userPkgs.sptlrx {})
    ];
  };

  networking.hosts = {
    "0.0.0.0" = ["apresolve.spotify.com"];
  };
}
