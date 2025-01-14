{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.asvetliakov.vscode-neovim
    ];
    userSettings = {
      "editor.lineNumbers" = "relative";
      "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      "workbench.sideBar.location" = "right";
    };
  };
}
