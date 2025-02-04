{
  lib,
  config,
  ...
}: {
  options.sharedOptions = {
    isWayland = lib.mkOption {
      default = lib.elem config.sharedOptions.desktopEnvironment ["hyprland" "river"];
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
        else "hyprland";
      description = "Sets the default desktop environment of the system.";
      type = lib.types.enum ["none" "hyprland" "river"];
    };
  };
}
