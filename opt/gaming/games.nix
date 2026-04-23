{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      yarg
      ringracers
    ];

    services.flatpak.packages = [
      "io.github.doukutsu_rs.doukutsu-rs"
    ];
  };
}
