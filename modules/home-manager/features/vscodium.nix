{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.biomejs.biome
    ];
    userSettings = {
      "editor.fontLigatures" = true;

      "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;
      "editor.lineNumbers" = "relative";
      "vscode-neovim.neovimClean" = true;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      "workbench.sideBar.location" = "right";
      "[typescript]"."editor.defaultFormatter" = "biomejs.biome";
    };
  };

  home.packages = with pkgs; [
    biome
  ];
}
