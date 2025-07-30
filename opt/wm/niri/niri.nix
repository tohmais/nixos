{...}: {
  imports = [../independent-wayland.nix];
  services.displayManager.defaultSession = "niri-session";
}
