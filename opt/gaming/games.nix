{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      yarg
      sm64coopdx
      shipwright
      ringracers
    ];

    services.flatpak.packages = [
      "io.github.doukutsu_rs.doukutsu-rs"
    ];
  };
}
