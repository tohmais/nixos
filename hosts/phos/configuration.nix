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
    
    spotify
    ncspot
    cava
    playerctl
    ungoogled-chromium
    fastfetch
    btop

    amberol
    nicotine-plus
    electron-mail
    gh
    git
    emacs-gtk
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

  system.stateVersion = "23.11"; # Did you read the comment?

}
