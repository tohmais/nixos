{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      yarg
      sm64coopdx
      shipwright
    ];

    services.flatpak.packages = [
      "io.github.doukutsu_rs.doukutsu-rs"
    ];
  };
}
