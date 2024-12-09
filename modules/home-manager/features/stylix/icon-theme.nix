{pkgs}: let
  link = "https://github.com/ljmill/catppuccin-icons/releases/download/v0.2.0/Catppuccin-SE.tar.bz2";
in
  pkgs.stdenv.mkDerivation {
    name = "catppuccin-se";

    src = pkgs.fetchurl {
      url = link;
      sha256 = "sha256-vM+ze+Sca2R5plcMRNEFftJ/5y0XElMojlFrFcJ47s8=";
    };

    dontUnpack = true;
    # Specify the build inputs
    buildInputs = [pkgs.gnutar];

    # The installation phase
    installPhase = ''
      mkdir -p $out
      tar xjf $src -C $out
      cd $out
      mv Catppuccin-SE/* .
      rm -rf Catppuccin-SE
    '';
  }
