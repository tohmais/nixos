{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      srb2
      srb2kart
      ringracers
      clonehero
      yarg
    ];

    services.flatpak.packages = [
      "io.github.doukutsu_rs.doukutsu-rs"
    ];
  };
}
