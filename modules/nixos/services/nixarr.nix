{inputs, ...}: {
  imports = [inputs.nixarr.nixosModules.default];

  nixarr = {
    enable = true;

    vpn = {
      enable = true;

      wgConf = "/data/.secret/wg.conf";

      transmission = {
        enable = true;
        vpn.enable = true;
        peerPort = 51820;
      };

      jellyfin.enable = true;
      
      bazarr.enable = true;
      sonarr.enable = true;
      radarr.enable = true;
      prowlarr.enable = true;
      lidarr.enable = true;
    };
  };
}