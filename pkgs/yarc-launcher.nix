{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
  hidapi,
  systemd,
  libudev-zero,
  uv,
}: let
  pname = "yarc-launcher";
  version = "1.3.0";

  src = fetchurl {
    url = "https://github.com/YARC-Official/YARC-Launcher/releases/download/v${version}/YARC.Launcher_${version}_amd64.AppImage";
    sha256 = "40e6e72370ed81f899f4660139ba076ad99d131bcabdca76499a3dceebb5e556";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = pkgs: [
      hidapi
      systemd
      libudev-zero
      uv
    ];

    extraInstallCommands = ''
          install -Dm644 \
            ${appimageContents}/usr/share/applications/*.desktop \
            $out/share/applications/yarc-launcher.desktop

      install -Dm644 \
        ${appimageContents}/usr/share/icons/hicolor/128x128/apps/yarc-launcher.png \
        $out/share/icons/hicolor/128x128/apps/yarc-launcher.png

    '';

    meta = {
      description = "Official launcher for YARG";
      homepage = "https://github.com/YARC-Official/YARC-Launcher";
      downloadPage = "https://github.com/YARC-Official/YARC-Launcher/releases";
      license = lib.licenses.mit;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      platforms = ["x86_64-linux"];
      mainProgram = "yarc-launcher";
    };
  }
