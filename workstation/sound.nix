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
    "11-bluetooth-policy" = {
      "wireplumber.settings" = {"bluetooth.autoswitch-to-headset-profile" = false;};
    };
  };

  hm = {
    services.mpris-proxy.enable = true;
    home.packages = with pkgs; [
      playerctl
      pwvucontrol
    ];
  };
}
