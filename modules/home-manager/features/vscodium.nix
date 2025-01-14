{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.asvetliakov.vscode-neovim
    ];
    settings = {
      "editor.lineNumbers" = "relative";

      "nix.enableLanguageServer" = true;
    };
  };
}
