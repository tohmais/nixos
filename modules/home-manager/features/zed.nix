{ pkgs, ... }:
{
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
      nix.binary.path_lookup = true;
    };
  };
  home.packages = with pkgs; [
    nil
    biome
  ];
}
