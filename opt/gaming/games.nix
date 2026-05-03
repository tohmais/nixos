{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      yarg
    ];

    services.flatpak.packages = [
      "io.github.doukutsu_rs.doukutsu-rs"
      "org.sonic3air.Sonic3AIR"
    ];
  };
}
