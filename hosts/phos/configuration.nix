# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, config, inputs, lib, ... }:
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  pkgs-hyprland =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;

    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      useOSProber = true;
      efiSupport = true;
    };
  };
  networking.hostName = "phos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  boot.supportedFilesystems = [ "ntfs" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
  time.hardwareClockInLocalTime = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    package = pkgs-hyprland.mesa.drivers;
    driSupport = true;
    driSupport32Bit = true;
    package32 = pkgs-hyprland.pkgsi686Linux.mesa.drivers;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  #services.mysql = {
  #  enable = true;
  #  package = pkgs.mariadb;
  #};

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.gamemode.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;


    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # NVIDIA Beta = 555
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.52.04";
      sha256_64bit = "sha256-nVOubb7zKulXhux9AruUTVBQwccFFuYGWrU1ZiakRAI=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk=";
      persistencedSha256 = lib.fakeSha256;

    };
  };

  security.polkit.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";

    desktopManager = {
      xfce.enable = true;
      xterm.enable = true;
    };

  };

  myNixOS = {
    bundles.general.enable = true;
    bundles.users.enable = true;
    home-users = {
      "callum" = {
        userConfig = ./home.nix;

      };

    };

  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.callum.enableGnomeKeyring = true;
  environment.sessionVariables = {

    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    
    NIXOS_OZONE_WL = "1";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  nix.settings.auto-optimise-store = true;

  services.blueman.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.callum = {
    isNormalUser = true;
    description = "Callum";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };
  # disabling jellyfin (227MB memory)
  #services.jellyfin = {
  #  enable = true;
  #  user = "callum";
  #  openFirewall = true;
  #};

  # Install firefox.
  programs.firefox.enable = true;
  nixpkgs.config.permittedInsecurePackages =
    [ "electron-25.9.0" "electron-19.1.9" "freeimage-unstable-2021-11-01" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = (with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    vesktop
    vscodium
    lxqt.lxqt-policykit
    nix-prefetch-scripts
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    kitty
    rofi-wayland
    obs-studio
    wl-clipboard
    xdg-utils
    grim
    slurp
    mysql-workbench
    spotify
    ncspot
    cava
    playerctl
    ungoogled-chromium
    fastfetch
    btop
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    amberol
    nicotine-plus
    electron-mail
    gh
    git
    emacs29-pgtk
    ripgrep
    fd
    coreutils
    clang
    gnumake
    pandoc
    cmakeMinimal
    libtool
    nixfmt-classic
    mangohud
    protonup
    r2modman
    davinci-resolve
    pinta
    krita
    mpv
    hyprpaper
    lutris
    protontricks
    bottles
    spicetify-cli
    p7zip
    libreoffice
    xivlauncher
    dua
    srb2kart
    mpdevil
    zoom-us
    ani-cli
    dolphin-emu
    sptlrx
    godot_4
    pegasus-frontend
    (pkgs.callPackage ./emulationstation-de/package.nix { })
    appimage-run
    (retroarch.override {
      cores = with libretro; [
        snes9x
        genesis-plus-gx
        beetle-saturn
        parallel-n64
        melonds
      ];
    })
    appeditor
    ncmpc
    jdk
    nwg-look
    nh
    wget
    libcap
    kdenlive
    pwvucontrol
    tor-browser
    tuxpaint
    librewolf
    kdePackages.qtsvg
    kdePackages.ark
    kdePackages.dolphin
    catppuccin-qt5ct
    libsForQt5.qt5ct
    kdePackages.qt6ct
    pipx
    clonehero
  ])

    ++

    (with pkgs-unstable; [ ryujinx zed-editor ]);
  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "GeistMono" ]; }) ];
  services.flatpak.enable = true;
  services.emacs = {

    enable = true;

    package = with pkgs;

      ((emacsPackagesFor emacs-gtk).emacsWithPackages

        (epkgs: with epkgs; ([ vterm ])));

    defaultEditor = true;

  };

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

  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin ];

  services.udev.packages = [ pkgs.dolphinEmu ];

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };
  services.mpd = {
    enable = true;
    musicDirectory = "/home/callum/Music/";
    extraConfig = ''
      audio_output {
       type "pipewire"
       name "My PipeWire Output"
      }
    '';

    # Optional:
    startWhenNeeded =
      true; # systemd feature: only start MPD service upon connection to its socket
    user = "callum";
  };

  programs.nix-ld.enable = true;
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.callum.uid}";
  };
  # disabling suwayomi because it was eating 500MB of memory
  #services.suwayomi-server = {
  #  enable = true;
  #  settings = {
  #    server = {
  #      extensionRepos = [
  #        "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
  #      ];
  #      webUIEnabled = true;
  #      webUIInterface = "browser";
  #      webUIFlavor = "WebUI";
  #    };

  #  };
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
