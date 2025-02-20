{...}: {
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
    logo = ./nixos-white.png;
  };
}
