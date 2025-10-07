{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}: {kernel}:
stdenv.mkDerivation rec {
  pname = "xpad-noone-upstream";
  version = "0-unstable-2025-09-04";

  src = fetchFromGitHub {
    owner = "forkymcforkface";
    repo = "xpad-noone";
    rev = "9ad89fdf2daeb29162a95702217bb9436ecf5da2f";
    sha256 = "sha256-etDsEXnbh3qC0Tri4vhHPsesNSkwNC48ryEWUiuj2Yo=";
  };

  setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  postPatch = ''
    substituteInPlace Makefile --replace-fail "/lib/modules/\$(shell uname -r)/build" "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  '';

  installPhase = ''
    runHook preInstall

    install *.ko -Dm444 -t $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/xpad-noone

    runHook postInstall
  '';

  meta = with lib; {
    description = "Xpad driver from the Linux kernel with support for Xbox One controllers removed, synchronised with upstream device support";
    homepage = "https://github.com/forkymcforkface/xpad-noone";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
