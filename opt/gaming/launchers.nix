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
            libXcursor
            libXi
            libXinerama
            libXScrnSaver
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
        dwproton-bin
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
      gamescope-wsi

      mangohud
      sgdboop

      protonup-rs
      protonplus

      winetricks

      # TODO: solution from https://github.com/NixOS/nixpkgs/issues/513245#issuecomment-4319854191, monitor when fixed
      (pkgs.lutris.override {
        # Intercept buildFHSEnv to modify target packages
        buildFHSEnv = args:
          pkgs.buildFHSEnv (args
            // {
              multiPkgs = envPkgs: let
                # Fetch original package list
                originalPkgs = args.multiPkgs envPkgs;

                # Disable tests for openldap
                customLdap = envPkgs.openldap.overrideAttrs (_: {doCheck = false;});
              in
                # Replace broken openldap with the custom one
                builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [customLdap];
            });
      })
      heroic
      prismlauncher
      xivlauncher
    ];
  };
}
