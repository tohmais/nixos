{ lib, buildGoModule, fetchFromGitHub, nix-update-script, testers, sptlrx }:

buildGoModule rec {
  pname = "sptlrx";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "raitonoberu";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-b8ALhEjolH0RH+I9HVQeOagPBi2isLNUxqKdj5u2O9s=";
  };

  vendorHash = lib.fakeHash;

  ldflags = [ "-s" "-w" ];

  passthru = {
    updateScript = nix-update-script { };
    tests.version = testers.testVersion {
      package = sptlrx;
      version = "v${version}"; # needed because testVersion uses grep -Fw
    };
  };

  meta = with lib; {
    description = "Spotify lyrics in your terminal";
    homepage = "https://github.com/raitonoberu/sptlrx";
    changelog = "https://github.com/raitonoberu/sptlrx/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ MoritzBoehme ];
    mainProgram = "sptlrx";
  };
}