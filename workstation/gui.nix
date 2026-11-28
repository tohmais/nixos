{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      bazaar

      bitwarden-desktop
      libreoffice
      electron-mail
      optipng # for mpv
    ];
    services.flatpak.packages = [
      "it.mijorus.gearlever"
      "com.usebottles.bottles"
    ];
    programs.mpv = {
      enable = true;
      config = {
        # NOTE: if you want mpv discord screensharing, you NEED pulseaudio!
        # i'd recommend making a entry in thunar to switch between the two.
        profile = "high-quality";
        vo = "gpu-next";
        hwdec = "auto-safe";
        gpu-api = "vulkan";

        target-colorspace-hint = "yes";
        target-colorspace-hint-mode = "source";
        save-position-on-quit = true;

        screenshot-format = "png";
        screenshot-dir = "~/Pictures/mpv";
        screenshot-template = "%F-%p-%n";
        screenshot-high-bit-depth = "no";
      };
    };
    /*
       xdg.configFile = {
      "mpv" = {
        source = builtins.fetchGit {
          url = "https://github.com/JySzE/SoM-MPV-Config.git";
          ref = "main-linux-wip";
          rev = "b7b61c2d24fd8379418108f20d72c9ad7fb1f17d";
        };
        recursive = true;
      };
    };
    */
  };
  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
    noto-fonts-cjk-sans
  ];

  security.wrappers.nethogs = {
    source = "${pkgs.nethogs}/bin/nethogs";
    capabilities = "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+ep";
    owner = "root";
    group = "wheel";
    permissions = "u+rx,g+x";
  };
}
