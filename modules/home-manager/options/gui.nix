{lib, ...}: {

  options.myHomeManager.terminal.name = lib.mkOption {
    default = "foot";
    description = "Sets default terminal emulator to the name specified.";
    type = lib.types.str;
  };

}