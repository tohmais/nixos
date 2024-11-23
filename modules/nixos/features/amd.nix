{ pkgs, config, lib, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl = {
   enable = true;
   driSupport = true;
   driSupport32Bit = true;
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
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    libvdpau-va-gl
  ];
  environment.systemPackages = with pkgs; [ rocmPackages.rocm-smi ];
  nixpkgs.config.rocmSupport = true;

  boot.kernelParams =
  lib.mapAttrsToList
  (
      name: m: let
      resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
      in "video=${name}:${resolution}"
  )
  (config.myNixOS.monitors);
}
