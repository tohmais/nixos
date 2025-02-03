{
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        useSystemClipboard = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
        };
        languages = {
          enableFormat = true;
          enableExtraDiagnostics = true;
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
        };

        filetree.nvimTree = {
          enable = true;

          # Damn you, DOOM emacs!
          mappings.toggle = "<leader>op";

          setupOpts = {
            git.enable = true;
            diagnostics.enable = true;
            hijack_cursor = true;
          };
        };

        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };
        statusline.lualine.enable = true;
        theme = {
          enable = true;
          name = "base16";
          style = "dark";
          base16-colors = {
            inherit (colors) base00 base01 base02 base03 base04 base05 base06 base07;
            inherit (colors) base08 base09 base0A base0B base0C base0D base0E base0F;
          };
          transparent = false;
        };
      };
    };
  };

  home.packages = with pkgs; [
    nodejs
    tree-sitter
    neovide
  ];
}
