{inputs, ...}: {
  imports = [inputs.nixarr.nixosModules.default];

  nixarr = {
    enable = true;

    vpn = {
      enable = true;

      wgConf = "/data/.secret/wg.conf";
    };

    transmission = {
      enable = true;
      vpn.enable = true;
    };

    jellyfin.enable = true;

    bazarr.enable = true;
    sonarr.enable = true;
    radarr.enable = true;
    prowlarr.enable = true;
    lidarr.enable = true;
    # jellyseerr.enable = true;
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 8082;
    services = [
      {
        "Services" = [
          {
            "Jellyfin" = {
              description = "An open-source media server.";
              href = "http://localhost:8096";
            };
          }
          {
            "Transmission" = {
              description = "A web-based BitTorrent client.";
              href = "http://localhost:9091";
            };
          }
          {
            "Sonarr" = {
              description = "Manage and download TV shows.";
              href = "http://localhost:8989";
            };
          }
          {
            "Radarr" = {
              description = "Manage and download movies.";
              href = "http://localhost:7878";
            };
          }
          {
            "Bazarr" = {
              description = "Subtitle management for Sonarr and Radarr.";
              href = "http://localhost:6767";
            };
          }
          {
            "Prowlarr" = {
              description = "Indexer management for Sonarr, Radarr, and Lidarr.";
              href = "http://localhost:9696";
            };
          }
          {
            "Lidarr" = {
              description = "Manage and download music.";
              href = "http://localhost:8686";
            };
          }
        ];
      }
    ];
  };
}
