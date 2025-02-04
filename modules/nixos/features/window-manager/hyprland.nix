{
  lib,
  config,
  ...
}: let
  de = config.sharedOptions.desktopEnvironment;
in {
  config = lib.mkIf (de == "hyprland") {
    programs.hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    services.displayManager.defaultSession = "hyprland";
  };
}
