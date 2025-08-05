{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      bottles
      gearlever
    ];
  };

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
  ];
}
