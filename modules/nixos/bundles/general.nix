{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  isServer = config.sharedOptions.isServer;
in {
  config = lib.mkMerge [
    {
      myNixOS = {
        cachix.enable = lib.mkDefault true;
        lix.enable = lib.mkDefault true;
        nh.enable = lib.mkDefault true;
      };

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
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
      };
    }
    (lib.mkIf (!isServer) {
      myNixOS.plymouth.enable = lib.mkDefault true;

      # Enable sound with pipewire.
      hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services = {
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };

        # Enable CUPS to print documents.
        printing.enable = true;
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
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
      services.pipewire.wireplumber.extraConfig = {
        "10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.roles" = ["a2dp_sink" "a2dp_source" "bap_sink" "bap_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
            "bluez5.enable-hw-volume" = true;
            "bluez5.hfphsp-backend" = "native";

            "bluez5.enable-msbc" = true;
            "bluez5.enable-sbc-xq" = true;
            # sbc_xq is the best quality codec that *my headphones* support. so, i'm forcing it to be used.
            # if i get headphones that support a better codec, i'll change this.
            "bluez5.codecs" = ["sbc_xq" "sbc"];
          };
        };
        "11-bluetooth-policy" = {
          "wireplumber.settings" = {"bluetooth.autoswitch-to-headset-profile" = false;};
        };
      };
      networking.networkmanager.enable = true;
      environment.systemPackages = with pkgs; [
        distrobox
        steam-run
      ];

      environment.localBinInPath = true;
      # I want to get shit done
      # (shoutout to this goated reddit comment https://www.reddit.com/r/NixOS/comments/1g4g1mp/comment/ls3kmzj)
      services.envfs.enable = true;

      programs.nix-ld = {
        libraries = with pkgs; [
          glibc
          libxcrypt
          libGL

          libdrm
          mesa # for libgbm
          udev
          libudev0-shim
          libva
          vulkan-loader

          networkmanager # not documented, used for network status things in Big Picture
          libcap # not documented, required by srt-bwrap

          xorg.libX11
          xorg.libXext
          gtk3
          alsa-lib
          icu

          dbus
          pkg-config
        ];
      };
    })
  ];
}
