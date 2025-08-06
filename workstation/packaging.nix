{inputs, ...}: {
  hm.imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;
  hm.services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
  ];
}
