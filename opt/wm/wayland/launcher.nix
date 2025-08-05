{
  lib,
  config,
  ...
}: {
  hm.programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "${config.hm.stylix.fonts.monospace.name}:size=${toString config.hm.stylix.fonts.sizes.popups}";
        width = 50;
        dpi-aware = "no";
      };
    };
  };
}
