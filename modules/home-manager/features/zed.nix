{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
    extensions = [
      "kanagawa-themes"
      "catppuccin-icons"

      "nix"
      "biome"
      "html"
      "toml"
    ];

    userSettings = {
      vim_mode = true;
      relative_line_numbers = true;
      ui_font_size = 16;
      buffer_font_family = "Lilex Nerd Font";
      buffer_font_size = 16;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Kanagawa";
      };
      load_direnv = "shell_hook";

      languages.Nix.language_servers = [
        "nixd"
        "!nil"
      ];

      lsp.nixd = {
        binary.path = lib.getExe pkgs.unstable.nixd;
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
    unstable.nixd
    biome
  ];
}
