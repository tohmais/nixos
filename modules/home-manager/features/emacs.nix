{ pkgs, ...} : {
  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29-pgtk;
  #   extraPackages = epkgs:
  #     with epkgs; [
  #       pdf-tools
  #       org-pdftools
  #       vterm
  #     ];
  # };

  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29-pgtk;
  # };

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];


  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs29-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        vterm
        pdf-tools
        org-pdftools
      ]
    ))

    ripgrep
    fd
  ];
}
