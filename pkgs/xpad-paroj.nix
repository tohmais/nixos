{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:
stdenv.mkDerivation rec {
  pname = "xpad-paroj";
  version = "0.4";

  src = fetchFromGitHub {
    owner = "paroj";
    repo = "xpad";
    rev = "9caad15ba366c26337bfbcf3ee1144a6cc07d9ca";
    sha256 = "sha256-wl6bZzEzLLc1OTy4EjLwmguTQVaiQgjf6WquYHeUbLg=";
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

    install *.ko -Dm444 -t $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/xpad

    runHook postInstall
  '';

  meta = with lib; {
    description = "xpad kernel module";
    homepage = "https://github.com/paroj/xpad";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
