{pkgs, ...}: {
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

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

  hm = {
    services.mpris-proxy.enable = true;
    home.packages = with pkgs; [
      playerctl
      pamixer
    ];
  };
}
