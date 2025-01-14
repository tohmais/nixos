{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        telescope.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
        };
      };
    };
  };
}
