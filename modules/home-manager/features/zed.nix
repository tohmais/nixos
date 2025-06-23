{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    extensions = [
      "catppuccin-icons"

      "nix"
      "biome"
      "html"
      "toml"
    ];

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
      relative_line_numbers = true;
      load_direnv = "shell_hook";

      diagnostics.inline.enabled = true;

      features.edit_prediction_provider = "zed";
      show_edit_predictions = true;

      languages.Nix.language_servers = [
        "nixd"
        "!nil"
      ];

      lsp.nixd = {
        binary.path = lib.getExe pkgs.nixd;
        initialization_options.formatting.command = [
          "alejandra"
          "--quiet"
          "--"
        ];
        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
          options = {
            nixos.expr = "(builtins.getFlake \"${config.home.homeDirectory}/nixos\").nixosConfigurations.${osConfig.networking.hostName}.options";
            home-manager.expr = "(builtins.getFlake \"${config.home.homeDirectory}/nixos\").homeConfigurations.\"${config.home.username}@${osConfig.networking.hostName}\".options";
          };
        };
      };
      icon_theme = "Catppuccin Mocha";
    };
  };
  home.packages = with pkgs; [
    nil
    nixd
    biome
  ];
}
