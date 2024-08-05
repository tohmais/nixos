# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, config, inputs, lib, ... }:
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};

in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
   loader = {
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
    supportedFilesystems = [ "ntfs" ];
  };

  networking.hostName = "phos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;
  time.hardwareClockInLocalTime = true;


  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  security.polkit.enable = true;
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
    bundles.gaming.enable = true;

    nvidia-wayland.enable = true;

    home-users = {
      "callum" = {
        userConfig = ./home.nix;
       };
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.callum.enableGnomeKeyring = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  nixpkgs.config.permittedInsecurePackages =
    [ "electron-25.9.0" "electron-19.1.9" "freeimage-unstable-2021-11-01" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = (with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    vesktop
    vscodium
    lxqt.lxqt-policykit
    nix-prefetch-scripts
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
    services.emacs = {

    enable = true;

    package = with pkgs;

      ((emacsPackagesFor emacs-gtk).emacsWithPackages

        (epkgs: with epkgs; ([ vterm ])));

    defaultEditor = true;

  };


  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin ];



  # disabling suwayomi because it was eating 500MB of memory
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
