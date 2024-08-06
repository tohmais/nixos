{ pkgs, lib, ... }: 
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  myHomeManager = {
    es-de.enable = lib.mkDefault true;
  };


  home.packages = (with pkgs; [
    mangohud
    
    protonup
    protontricks

    r2modman
    lutris

    xivlauncher
    srb2kart
    clonehero

    dolphin-emu
    (retroarch.override {
      cores = with libretro; [
        snes9x
        genesis-plus-gx
        beetle-saturn
        parallel-n64
        melonds
      ];
    })
  ])
  
  ++

  (with pkgs-unstable; [
    ryujinx 
  ]);
}