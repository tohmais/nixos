{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:
stdenv.mkDerivation rec {
  pname = "xpad";
  version = "0.4";

  src = fetchFromGitHub {
    owner = "paroj";
    repo = "xpad";
    rev = "902ffabe6cc6c3cbbdc5c55f163a0fc59e5fd8f3";
    sha256 = "sha256-vTpyI1QbirCsvkQ0xRrEeYfgsvADau6PKSELcXKXMMk=";
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
