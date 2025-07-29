{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    distrobox
    steam-run
  ];

  environment.localBinInPath = true;
  # I want to get shit done
  # (shoutout to this goated reddit comment https://www.reddit.com/r/NixOS/comments/1g4g1mp/comment/ls3kmzj)
  services.envfs.enable = true;

  programs.nix-ld = {
    libraries = with pkgs; [
      glibc
      libxcrypt
      libGL

      libdrm
      mesa # for libgbm
      udev
      libudev0-shim
      libva
      vulkan-loader

      networkmanager # not documented, used for network status things in Big Picture
      libcap # not documented, required by srt-bwrap

      xorg.libX11
      xorg.libXext
      gtk3
      alsa-lib
      icu

      dbus
      pkg-config
    ];
  };
}
