{
  lib,
  stdenv,
  cmake,
  fetchzip,
  pkg-config,
  alsa-lib,
  curl,
  ffmpeg,
  freeimage,
  freetype,
  libgit2,
  poppler,
  pugixml,
  SDL2
}:

stdenv.mkDerivation {
  pname = "emulationstation-de";
  version = "3.0.2";

  src = fetchzip {
    url = "https://gitlab.com/es-de/emulationstation-de/-/archive/v3.0.2/emulationstation-de-v3.0.2.tar.gz";
    hash = "sha256:02xsy3v3cik41ls8qjvjjm7viwm2fxisfqvsx1x8qpfv4qbmfsa4";
  };

  patches = [ ./001-add-nixpkgs-retroarch-cores.patch ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    alsa-lib
    curl
    ffmpeg
    freeimage
    freetype
    libgit2
    poppler
    pugixml
    SDL2
  ];

  installPhase = ''
    install -D ../es-de $out/bin/es-de
    cp -r ../resources/ $out/bin/resources/
    install -Dm 644 ../es-app/assets/org.es_de.frontend.desktop -t $out/share/applications/ 
    install -Dm 644 ../es-app/assets/org.es_de.frontend.svg -t $out/share/icons/hicolor/scalable/apps/
  '';

  meta = {
    description = "EmulationStation Desktop Edition is a frontend for browsing and launching games from your multi-platform game collection.";
    homepage = "https://es-de.org";
    maintainers = with lib.maintainers; [ ivarmedi ];
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "emulationstation";
  };
}
