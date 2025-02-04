{lib, ...}: {
  options.myNixOS.isProfessional = lib.mkOption {
    default = false;
    description = "Sets whether the machine is used in a professional context.";
    type = lib.types.bool;
  };
}
