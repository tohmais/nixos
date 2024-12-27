{pkgs, config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons";
      vim = "${pkgs.neovim}/bin/nvim";
    };
    history = {
      share = true;
    };
  };

  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };
  programs.oh-my-posh = {
    enable = true;
    settings = {
      source = config.lib.stylix.colors {
        template = builtins.readFile ./stylix-theme.json.mustache;
        extension = ".json";
      };
    };
  };
  home.packages = with pkgs; [
    eza
  ];
}
