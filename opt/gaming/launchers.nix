{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs':
          with pkgs'; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib # Provides libstdc++.so.6
            libkrb5
            keyutils
            # Add other libraries as needed
          ];
      };
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
      platformOptimizations.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
      extraPackages = with pkgs; [
        SDL2
        gamescope
      ];
      protontricks.enable = true;
      extest.enable = true;
    };
    gamescope = {
      enable = true;

      # this breaks running gamescope in steam, for some reason.
      # set to false to make it work.
      capSysNice = false;
    };
    gamemode.enable = true;
  };

  hm = {
    home.packages = with pkgs; [
      mangohud
      adwsteamgtk
      sgdboop

      protonup-ng
      protonup-qt
      winetricks

      lutris
      heroic

      prismlauncher
      xivlauncher
    ];
  };
}
