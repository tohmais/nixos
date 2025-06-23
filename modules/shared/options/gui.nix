{
  lib,
  config,
  ...
}: {
  options.sharedOptions = {
    isWayland = lib.mkOption {
      default = lib.elem config.sharedOptions.desktopEnvironment ["hyprland" "river" "kde"];
      description = "Sets whether the machine that is used is primarily using a Wayland desktop environment.";
      type = lib.types.bool;
    };
    isServer = lib.mkOption {
      default = false;
      description = "Sets whether the machine that is used is a server machine or not.";
      type = lib.types.bool;
    };
    desktopEnvironment = lib.mkOption {
      default =
        if config.sharedOptions.isServer
        then "none"
        else if config.sharedOptions.isHandheld
        then "kde"
        else "hyprland";
      description = "Sets the default desktop environment of the system.";
      type = lib.types.enum ["none" "hyprland" "river" "kde"];
    };
    isHandheld = lib.mkOption {
      default = false;
      description = "Sets whether the system is a gaming handheld, like the Steam Deck.";
      type = lib.types.bool;
    };
  };
}
