{ lib, stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "delphitools-cli";
  version = "0.2.0";

  src = fetchurl {
    url = "https://github.com/1612elphi/delphitools-cli/releases/download/v${version}/delphitools-cli-x86_64-unknown-linux-gnu.tar.xz";
    hash = "sha256-Jhudr1lRyKugIrdG5JXIudObfW4YFh6Clgmv31DKELA=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  sourceRoot = "delphitools-cli-x86_64-unknown-linux-gnu";

  installPhase = ''
    runHook preInstall
    install -Dm755 delphitools $out/bin/delphitools
    ln -s delphitools $out/bin/delphi
    ln -s delphitools $out/bin/dt
    runHook postInstall
  '';

  meta = with lib; {
    description = "Delphi tools CLI";
    homepage = "https://github.com/1612elphi/delphitools-cli";
    license = licenses.mit; # adjust if known
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
