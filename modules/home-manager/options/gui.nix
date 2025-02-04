{
  lib,
  config,
  ...
}: {
  options.myHomeManager.terminal.name = lib.mkOption {
    default =
      if config.sharedOptions.isWayland
      then "foot"
      else "kitty";
    description = "Sets default terminal emulator to the name specified.";
    type = lib.types.str;
  };
}
