


{pkgs, lib}: let
  link = "https://github.com/ljmill/catppuccin-icons/releases/download/v0.2.0/Catppuccin-SE.tar.bz2";
in
  pkgs.stdenv.mkDerivation {
    name = "catppuccin-se";

    src = pkgs.fetchurl {
      url = link;
      sha256 = "sha256-1kzfg311assiiql564hp5pkpzlky0p8l832plrwn8swwwixv7kxw=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out
      ${pkgs.p7zip}/bin/7z x $src
      ${pkgs.p7zip}/bin/7z x ${lib.strings.removeSuffix ".tar" "$src"} -o$out
    '';
  }