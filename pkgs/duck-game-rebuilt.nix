{
  stdenv,
  fetchurl,
  unzip,
  makeDesktopItem,
  buildFHSEnv,
  mono,
  SDL2,
  lib,
}: let
  pname = "duck-game-rebuilt";
  version = "1.4.7";

  DGR = stdenv.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/TheFlyingFoool/DuckGameRebuilt/releases/download/v${version}/DuckGameRebuilt.zip";
      sha256 = "1idnca210wdvlq6224i1961hqk72cxhljg9myfacccq7bkl997fw";
    };

    dontBuild = true;
    dontConfigure = true;
    dontStrip = true;

    nativeBuildInputs = [unzip];

    sourceRoot = ".";

    unpackPhase = ''
      mkdir -p $out/bin
      unzip $src -d $out/bin
    '';

    installPhase = ''
      chmod +x $out/bin/DuckGame.sh
    '';
  };
  desktopItem = makeDesktopItem {
    name = "Duck Game Rebuilt";
    exec = "duck-game-rebuilt";
    genericName = "Duck Game decompiled & rebuilt with some added features";
    desktopName = "Duck Game Rebuilt";
    icon = "DuckGame"; # I know it's broken I'll deal with it later
  };
in
  buildFHSEnv {
    name = pname;
    targetPkgs = pkgs: [
      mono
      SDL2
    ];

    extraInstallCommands = ''
      mkdir -p $out/share/{icons,applications}
      ln -s ${DGR}/DuckGame/DuckGame.ico $out/share/icons/
      ln -s ${desktopItem}/share/applications/* $out/share/applications/
    '';

    runScript = "${DGR}/bin/DuckGame.sh -norebuiltupdates";

    meta = with lib; {
      description = "Duck Game decompiled & rebuilt with some added features";
      longDescription = ''
        Duck Game Rebuilt is a decompilation of Duck Game with massive improvements to performance, compatibility, and quality of life features.
      '';
      homepage = "https://github.com/TheFlyingFoool/DuckGameRebuilt";
      license = licenses.unlicense;
      platform = platforms.linux;
      maintainers = with maintainers; [klof44];
    };
  }
