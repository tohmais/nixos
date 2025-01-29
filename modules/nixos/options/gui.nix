{lib, ...}: {
  options.myNixOS.isProfessional = lib.mkOption {
    default = false;
    description = "Sets whether the machine is used in a professional context.";
    type = lib.types.bool;
  };
  options.myNixOS.isWayland = lib.mkOption {
    default = true;
    description = "Sets whether the machine that is used is primarily using a Wayland desktop environment.";
    type = lib.types.bool;
  };
}
