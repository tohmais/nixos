{lib, config, ...}: {
  options.myHomeManager.terminal.name = lib.mkOption {
    default = if config.myHomeManager.isWayland then "foot" else "kitty";
    description = "Sets default terminal emulator to the name specified.";
    type = lib.types.str;
  };
  options.myHomeManager.isWayland = lib.mkOption {
    default = true;
    description = "Sets whether the machine that is used is primarily using a Wayland desktop environment.";
    type = lib.types.bool;
  };
}
