{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      bottles
      gearlever

      libreoffice
      electronmail
    ];
  };

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
  ];
}
