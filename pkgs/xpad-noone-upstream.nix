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
    owner = "tohmais";
    repo = "xpad-noone";
    rev = "b32477c8807c3fd88e1a0bcbc2426941e570906c";
    sha256 = "sha256-CzuIa9KQZz7lpwXu5ALd+JkDatfLOQ84UQqMXS6GCiA=";
  };

  setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  postPatch = ''
    substituteInPlace Makefile --replace-fail "/lib/modules/\$(KVERSION)/build" "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
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
