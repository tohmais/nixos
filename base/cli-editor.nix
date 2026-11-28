{
  pkgs,
  config,
  inputs,
  ...
}: {
  hm = {
    imports = [inputs.nvf.homeModules.default];

    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          spellcheck = {
            enable = true;
            programmingWordlist.enable = true;
            languages = [
              "en"
            ];
          };
          package = pkgs.neovim-unwrapped;
          viAlias = true;
          vimAlias = true;
          preventJunkFiles = true;
          clipboard = {
            enable = true;
            registers = "unnamedplus";
            providers.wl-copy.enable = true;
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
            markdown.enable = true;
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
          notes.todo-comments.enable = true;
        };
      };
    };

    home.packages = with pkgs; [
      tree-sitter
    ];
  };
}
