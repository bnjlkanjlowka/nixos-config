{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  alsa-lib,
  wayland,
  libxkbcommon,
  libglvnd,
  patchelf,
  ...
}:

rustPlatform.buildRustPackage {
  pname = "mic-bridge";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "dieterpl";
    repo = "micbridge";
    rev = "9a262a8";
    hash = "sha256-GH4SZJvzKKMtFicB6cAZ926LADGFNxHK9pMWPSfzwwE=";
  };

  cargoHash = "sha256-Dnyr4TbCD1koXa3ECr/mNXS33mh+7NhRx9utQDSMAgo=";

  nativeBuildInputs = [
    pkg-config
    patchelf
  ];

  buildInputs = [
    alsa-lib
    wayland
    libxkbcommon
    libglvnd
  ];

  postFixup = ''
    patchelf \
    --add-rpath "${wayland}/lib:${libxkbcommon}/lib:${libglvnd}/lib" \
    $out/bin/micbridge-gui
  '';

  postInstall = ''
    mkdir -p $out/share/applications

    cat > $out/share/applications/micbridge.desktop <<EOF
    [Desktop Entry]
    Name=micbridge
    Comment=Microphone for Windows wm
    Exec=$out/bin/micbridge-gui
    Terminal=false
    Type=Application
    Categories=AudioVideo;Audio;
    EOF
  '';

  meta = {
    description = "mic for windows";
    homepage = "https://github.com/dieterpl/micbridge";
    license = lib.licenses.asl20;
    mainProgram = "micbridge-gui";
  };
}
