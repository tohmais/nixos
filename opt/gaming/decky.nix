{
  inputs,
  mainUser,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.jovian-nixos.nixosModules.default];

  jovian.decky-loader = {
    enable = true;
    user = mainUser;
    extraPackages = [pkgs.systemd];
    package = pkgs.decky-loader-prerelease;
  };

  # Create Steam CEF debugging file if it doesn't exist for Decky Loader.
  systemd.services.steam-cef-debug = lib.mkIf config.jovian.decky-loader.enable {
    description = "Create Steam CEF debugging file";
    serviceConfig = {
      Type = "oneshot";
      User = mainUser;
      ExecStart = "/bin/sh -c 'mkdir -p ~/.steam/steam && [ ! -f ~/.steam/steam/.cef-enable-remote-debugging ] && touch ~/.steam/steam/.cef-enable-remote-debugging || true'";
    };
    wantedBy = ["multi-user.target"];
  };
}
