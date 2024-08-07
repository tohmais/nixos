{inputs, pkgs, config, ...}:
# let
#   pkgs-hyprland =
#     inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
# in 
{
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  # hardware.opengl = {
  #   package = pkgs-hyprland.mesa.drivers;
  #   package32 = pkgs-hyprland.pkgsi686Linux.mesa.drivers;
  # };
}
