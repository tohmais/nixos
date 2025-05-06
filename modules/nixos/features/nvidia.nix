{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # NVIDIA Beta = 560
    package =
      # (pkgs.unstable.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.stable;
      # config.boot.kernelPackages.nvidiaPackages.beta;
      config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "570.133.07";
        # this is the third one it will complain is wrong
        sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
        # unused
        sha256_aarch64 = "sha256-2l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
        # this is the second one it will complain is wrong
        openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
        # this is the first one it will complain is wrong
        settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
        # unused
        persistencedSha256 = "sha256-4l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
      };
  };

  # Note that I haven't set up the prime offload in this file because I use the settings from nixos-hardware instead.
  environment.sessionVariables = lib.mkIf (config.sharedOptions.isWayland && !config.myNixOS.isPrime) {
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  boot.kernelParams = lib.mkDefault ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };
}
