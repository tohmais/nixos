{ lib, pkgs, ...}: {
  myNixOS = {
    steam.enable = lib.mkDefault true;
    gc-controller.enable = lib.mkDefault true;
  };

  # we have to install retroarch for all users so other
  # programs can source retroarch cores correctly.
  environment.systemPackages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        snes9x
        genesis-plus-gx
        beetle-saturn
        parallel-n64
        melonds
        mgba
      ];
    })
  ];

}
