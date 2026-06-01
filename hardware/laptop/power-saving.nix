{
  pkgs,
  inputs,
  system,
  ...
}: {
  services = {
    auto-cpufreq.enable = true;
    tlp.enable = false;
    upower.enable = true;
    logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
  };

  powerManagement.enable = true;

  /*
     systemd.services.watt = {
    description = "Watt service";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${inputs.watt.packages.${system}.watt}/bin/watt";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
  */

  hm.home.packages = with pkgs; [
    powertop
  ];
}
