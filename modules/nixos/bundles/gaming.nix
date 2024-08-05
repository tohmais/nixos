{ lib, ...}: {
  myNixOS = {
    steam.enable = lib.mkDefault true;
    gc-controller.enable = lib.mkDefault true;
  };
}
