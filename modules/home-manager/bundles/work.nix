{pkgs, lib, ...}: {

  myHomeManager = {
    bundles.gui.enable = true;
  };

  services.flatpak.packages = [
    "com.google.Chrome"
  ];

  # home.packages = with pkgs; [
  #   teams
  # ];
}