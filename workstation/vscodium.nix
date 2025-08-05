{
  pkgs,
  osConfig,
  mainUser,
  ...
}: {
  hm = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        extensions = with pkgs; [
          vscode-extensions.jnoortheen.nix-ide
          vscode-extensions.asvetliakov.vscode-neovim
          vscode-extensions.biomejs.biome
          vscode-extensions.mkhl.direnv
        ];
        userSettings = {
          "editor.fontLigatures" = true;

          "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;
          "editor.lineNumbers" = "relative";
          "vscode-neovim.neovimClean" = true;

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings".nixd = {
            formatting.command = ["alejandra" "--quiet" "--"];

            options = {
              nixos.expr = "(builtins.getFlake \"/home/${mainUser}/nixos\").nixosConfigurations.${osConfig.networking.hostName}.options";
              home-manager.expr = "(builtins.getFlake \"/home/${mainUser}/nixos\").homeConfigurations.\"${mainUser}@${osConfig.networking.hostName}\".options";
            };
          };

          "workbench.sideBar.location" = "right";
          "[typescript]"."editor.defaultFormatter" = "biomejs.biome";
        };
      };
    };

    home.packages = with pkgs; [
      biome
      code-cursor
    ];
  };
}
