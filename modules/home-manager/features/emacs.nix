{ pkgs, ...} : {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        pdf-tools
        org-pdftools
        vterm
      ];
  };

  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29-pgtk;
  # };

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];


  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
