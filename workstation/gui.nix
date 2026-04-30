{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      gearlever
      (pkgs.bottles.override {
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
      bazaar

      bitwarden-desktop
      libreoffice
      electron-mail
    ];

    programs.mpv = {
      enable = true;
      config = {
        # NOTE: if you want mpv discord screensharing, you NEED pulseaudio!
        # i'd recommend making a entry in thunar to switch between the two.
        profile = "gpu-hq";
        vo = "gpu-next";
        hwdec = "auto-copy";
        gpu-api = "vulkan";
        video-sync = "display-resample";
        interpolation = "yes";
        target-colorspace-hint = "yes";
        hdr-reference-white = 150;
      };
    };
  };

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    noto-fonts-cjk-sans
  ];
}
