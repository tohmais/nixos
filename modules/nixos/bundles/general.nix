{ pkgs, lib, ... }: {
  myNixOS = {
    sddm.enable = lib.mkDefault true;
    cachix.enable = lib.mkDefault true;
    nix-alien.enable = lib.mkDefault true;
  };
}
