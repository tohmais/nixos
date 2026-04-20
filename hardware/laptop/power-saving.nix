{pkgs, ...}: {
  services = {
    auto-cpufreq.enable = true;
    tlp.enable = false;
    upower.enable = true;
    logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
  };

  powerManagement.enable = true;

  hm.home.packages = with pkgs; [
    powertop
  ];
}
