{
  pkgs,
  lib,
  inputs,
  ...
}: {
  myNixOS = {
    sddm.enable = lib.mkDefault true;
    cachix.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    lix.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
  };

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };

  services.flatpak.enable = true;
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

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "NerdFontsSymbolsOnly"];})
    corefonts
    dejavu_fonts
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;
  services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {"wireplumber.settings" = {"bluetooth.autoswitch-to-headset-profile" = false;};};

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run
    distrobox
  ];

  # I want to get shit done 
  # (shoutout to this goated reddit comment https://www.reddit.com/r/NixOS/comments/1g4g1mp/comment/ls3kmzj)
  
  programs.nix-ld = {
    libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
  }; 

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
  # For nix LSP support
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
