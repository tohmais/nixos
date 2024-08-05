{ pkgs, config, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons -a"
    };
    history = {
        share = true;
    };
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.packages = with pkgs; [
    eza
  ];
}
