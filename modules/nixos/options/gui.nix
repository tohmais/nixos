{lib, ...}: {
  options.myNixOS = {
    isProfessional = lib.mkOption {
      default = false;
      description = "Sets whether the machine is used in a professional context.";
      type = lib.types.bool;
    };
    isPrime = lib.mkOption {
      default = false;
      description = "Sets whether the machine is using an NVIDIA gpu with Optimus (APU + Dedicated GPU) on a laptop";
      type = lib.types.bool;
    };
  };
}
