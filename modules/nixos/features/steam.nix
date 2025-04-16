{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];
  
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.steam.platformOptimizations.enable = true;
  programs.gamemode.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };
}
