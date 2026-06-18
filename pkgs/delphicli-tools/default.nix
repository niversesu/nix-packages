{ lib, stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "delphitools-cli";
  version = "0.2.0";

  src = fetchurl {
    url = "https://github.com/1612elphi/delphitools-cli/releases/download/v${version}/delphitools-cli-x86_64-unknown-linux-gnu.tar.xz";
    hash = "sha256-HPaP2XekvL1FSUqb/+MIy+jVPwjn593hlfJe9rJqCZY=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 delphitools-cli $out/bin/delphitools-cli
    runHook postInstall
  '';

  meta = with lib; {
    description = "Delphi tools CLI";
    homepage = "https://github.com/1612elphi/delphitools-cli";
    license = licenses.unfree; # adjust if known
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
