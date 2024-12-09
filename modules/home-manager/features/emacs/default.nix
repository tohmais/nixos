{
  pkgs,
  config,
  ...
}: let
  f = config.stylix.fonts;
in {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        pdf-tools
        org-pdftools
        vterm
      ];
  };

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];

  xdg.configFile = {
    "doom/+stylix.el".text = ''
      ;;; +stylix.el -*- lexical-binding: t; -*-

      ; Setup Fonts from Stylix
      (after! doom-themes
        (setq doom-font (font-spec :family "${f.monospace.name}" :size ${toString (f.sizes.terminal)})
              doom-variable-pitch-font (font-spec :family "${f.monospace.name}" :size ${toString (f.sizes.terminal)})
              doom-big-font (font-spec :family "${f.monospace.name}" :size ${toString (f.sizes.terminal + 2)})
              doom-symbol-font (font-spec :family "${f.emoji.name}")))

    '';

    "doom/themes/doom-stylix-theme.el" = {
      source = config.lib.stylix.colors {
        template = builtins.readFile ./doom-stylix-theme.el.mustache;
        extension = ".el";
      };
    };
  };

  home.sessionVariables = {
    DOOMDIR = "$XDG_CONFIG_HOME/doom";
    EMACSDIR = "$XDG_CONFIG_HOME/emacs";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    ranger
  ];
}
