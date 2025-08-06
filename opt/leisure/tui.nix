{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    pipes-rs
    fastfetch
    cbonsai
    neo
  ];
}
