{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  myNixOS = {
    bundles.gui.enable = lib.mkDefault true;

    steam.enable = lib.mkDefault true;
    gc-controller.enable = lib.mkDefault true;
    xpad.enable = lib.mkDefault true;
  };

  services.pipewire.lowLatency.enable = true;
  # we have to install retroarch for all users so other
  # programs can source retroarch cores correctly.
  environment.systemPackages = with pkgs; [
    steamtinkerlaunch
  ];
}
