{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      show-icons = true;
      display-drun = "> ";
      font = "${config.stylix.fonts.monospace.name} ${toString config.stylix.fonts.sizes.terminal}";
    };
  };
}
