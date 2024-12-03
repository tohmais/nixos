{ pkgs, config, lib, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
   enable = true;
   enable32Bit = true;
  };
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    libvdpau-va-gl
  ];
  environment.systemPackages = with pkgs; [ rocmPackages.rocm-smi ];
  nixpkgs.config.rocmSupport = true;
}
