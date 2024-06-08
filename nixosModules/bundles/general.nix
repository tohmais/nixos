{ pkgs, lib, ... }: {
  myNixOS.sddm.enable = lib.mkDefault true;

}
