{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = {
    assertions = [
      {
        assertion = config.sharedOptions.desktopEnvironment != "none";
        message = "You must enable a desktop environment to enable bundles.gui.enable";
      }
    ];

    myNixOS = {
      bundles.general.enable = lib.mkDefault true;
      window-manager.enable = lib.mkForce true;

      sddm.enable = lib.mkDefault true;
      stylix.enable = lib.mkDefault true;
      thunar.enable = lib.mkDefault true;
      vpn.enable = lib.mkDefault true;
    };

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    xdg.portal.enable = true;

    services.flatpak.enable = true;

    fonts.packages = with pkgs; [
      (nerdfonts.override {fonts = ["Lilex" "NerdFontsSymbolsOnly"];})
      corefonts
      dejavu_fonts
    ];

    # For nix LSP support
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
}
