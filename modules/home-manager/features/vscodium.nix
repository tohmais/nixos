{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.esbenp.prettier-vscode
    ];
    userSettings = {
      "editor.lineNumbers" = "relative";
      "editor.fontLigatures" = true;
      "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      "workbench.sideBar.location" = "right";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
  };
}
