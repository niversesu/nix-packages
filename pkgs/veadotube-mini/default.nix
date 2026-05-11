{ lib
, stdenv
, fetchurl
, makeWrapper
, autoPatchelfHook
, unzip
, libusb1
, libGL
, libglvnd
, alsa-lib
, libjack2
, pipewire
, libpulseaudio
, sndio
, libXtst
, libXScrnSaver
, libXrandr
, libXfixes
, libXi
, libXcursor
, libXext
, libX11
, vulkan-loader
, libdrm
, libdecor
, libxkbcommon
, wayland
, fribidi
, dbus
, systemd
, liburing
, mesa
, icu
}:
let
  pname = "veadotube-mini";
  version = "2.0";
  icon = fetchurl {
    url = "https://pub-786f3caa6e0c467d81af67b260388ae9.r2.dev/veadotube-mini-icon.png";
    sha256 = "sha256-DjALRh4SxiT0uEpoDj7NTsOQRButzAOfE3DcviHTN8w=";
  };
in stdenv.mkDerivation {
  inherit pname version;
  src = fetchurl {
    url = "https://pub-786f3caa6e0c467d81af67b260388ae9.r2.dev/veadotube-mini-linux-x64.zip";
    sha256 = "sha256-JHgC9nhMTr76zavmj8kzmdTyOwWFdSJ1lEpx26yAnrA=";
  };
  nativeBuildInputs = [ unzip makeWrapper autoPatchelfHook ];
  buildInputs = [
    stdenv.cc.cc.lib
    libusb1
    libGL
    libglvnd
    alsa-lib
    libjack2
    pipewire
    libpulseaudio
    sndio
    libXtst
    libXScrnSaver
    libXrandr
    libXfixes
    libXi
    libXcursor
    libXext
    libX11
    vulkan-loader
    libdrm
    libdecor
    libxkbcommon
    wayland
    fribidi
    dbus
    systemd
    liburing
    mesa
    icu
  ];
  autoPatchelfIgnoreMissingDeps = [ "libsteam_api.so" "libGLES_CM.so.1" ];
  unpackPhase = ''
    unzip $src
  '';
  installPhase = ''
    mkdir -p $out/bin $out/share/veadotube-mini
    cp veadotube-mini $out/share/veadotube-mini/
    cp -r lib $out/share/veadotube-mini/
    cp -r text $out/share/veadotube-mini/
    makeWrapper $out/share/veadotube-mini/veadotube-mini $out/bin/veadotube-mini \
      --chdir "$out/share/veadotube-mini" \
      --prefix LD_LIBRARY_PATH : ${icu}/lib \
      --set DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 1
    mkdir -p $out/share/applications
    cat > $out/share/applications/${pname}.desktop << EOF
[Desktop Entry]
Name=Veadotube Mini
Exec=veadotube-mini
Icon=veadotube-mini
Type=Application
Categories=Graphics;Video;
Comment=VTuber avatar app
StartupWMClass=veadotube-mini
EOF
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp ${icon} $out/share/icons/hicolor/256x256/apps/${pname}.png
  '';
  meta = with lib; {
    description = "Veadotube mini - lightweight VTuber avatar app";
    homepage = "https://veado.tube";
    license = licenses.free;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
