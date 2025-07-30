{
  pkgs,
  config,
  inputs,
  ...
}: {
  hm = {
    imports = [inputs.nvf.homeManagerModules.default];

    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          package = pkgs.neovim-unwrapped;
          viAlias = true;
          vimAlias = true;
          clipboard = {
            enable = true;
            registers = "unnamedplus";
          };
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          lsp = {
            enable = true;
            formatOnSave = true;
            lightbulb.enable = true;
            lspkind.enable = true;
          };
          languages = {
            enableFormat = true;
            enableExtraDiagnostics = true;
            enableTreesitter = true;
            nix.enable = true;
          };
          luaConfigPost = ''
            vim.opt.expandtab = true
          '';
          options = {
            tabstop = 2;
            shiftwidth = 0;
          };
          filetree.nvimTree = {
            enable = true;

            # Damn you, DOOM emacs!
            mappings.toggle = "<leader>op";
            openOnSetup = false;

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
        };
      };
    };

    home.packages = with pkgs; [
      tree-sitter
    ];
  };
}
