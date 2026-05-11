{ lib
, stdenv
, fetchFromGitHub
, cmake
, ninja
, pkg-config
, obs-studio
, pipewire
, libdrm
, libGL
}:

stdenv.mkDerivation rec {
  pname = "obs-pwvideo";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "hoshinolina";
    repo = "obs-pwvideo";
    rev = version;
    sha256 = "sha256-CCzeK5JyCWnIcty5xaDV5uCxvrMVx50f8SoLZnlF658=";
  };

  nativeBuildInputs = [ cmake ninja pkg-config ];

  buildInputs = [
    obs-studio
    pipewire
    libdrm
    libGL
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=RelWithDebInfo"
    "-DCMAKE_INSTALL_LIBDIR=lib"
    "-DCMAKE_INSTALL_DATADIR=share/obs/obs-plugins"
  ];

  meta = with lib; {
    description = "OBS generic PipeWire video source";
    homepage = "https://github.com/hoshinolina/obs-pwvideo";
    license = licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
  };
}
