{ pkgs, ...} : {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs:
      with epkgs; [
        pdf-tools
        org-pdftools
        vterm
      ];
  };

  home.packages = with pkgs; [
    ripgrep
    fd

  ];
}
