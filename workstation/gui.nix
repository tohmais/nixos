{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      mission-center
      bottles
      gearlever

      libreoffice
      electron-mail
    ];
  };

  fonts.packages = with pkgs; [
    corefonts
    dejavu_fonts
  ];
}
