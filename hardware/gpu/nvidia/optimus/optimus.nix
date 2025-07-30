{...}: {
  imports = [ ../generic.nix ];
  
  hardware.nvidia.prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # Provides `nvidia-offload` command.
      };
      # Hardware should specify the bus ID for intel/nvidia devices
    };
}