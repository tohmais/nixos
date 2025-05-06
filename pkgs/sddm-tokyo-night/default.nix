{
  lib,
  stdenv,
  fetchFromGitHub,
  libsForQt5,
}:
stdenv.mkDerivation {
  name = "sddm-tokyo-night";
  src = fetchFromGitHub {
    owner = "siddrs";
    repo = "tokyo-night-sddm";
    rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
    sha256 = "1gf074ypgc4r8pgljd8lydy0l5fajrl2pi2avn5ivacz4z7ma595";
  };

  dontWrapQtApps = true;
  
  propagatedBuildInputs = [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
  
  ];
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
  
}
