{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package =
      if config.sharedOptions.isWayland
      then pkgs.rofi-wayland
      else pkgs.rofi;
    extraConfig = {
      show-icons = true;
      display-drun = "> ";
      font = "${config.stylix.fonts.monospace.name} ${toString config.stylix.fonts.sizes.terminal}";
    };
  };
}
