{...}: {
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
    logo = ../assets/nixos-white.png;
  };
}
