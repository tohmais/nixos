{lib, ...}: {
  options.sharedOptions.isWayland = lib.mkOption {
    default = true;
    description = "Sets whether the machine that is used is primarily using a Wayland desktop environment.";
    type = lib.types.bool;
  };
  options.sharedOptions.isServer = lib.mkOption {
    default = false;
    description = "Sets whether the machine that is used is a server machine or not.";
    type = lib.types.bool;
  };
}
