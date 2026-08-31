{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "gnome-mpris-label";
  version = "43";

  src = fetchFromGitHub {
    owner = "Moon-0xff";
    repo = "gnome-mpris-label";
    tag = "v${version}";
    hash = "sha256-sqnbBuBimaE0LMV6dmwnuAPbbhwG7tFlxEJ098Nkrpw=";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/mprisLabel@moon-0xff.github.com
    cp -r ./* $out/share/gnome-shell/extensions/mprisLabel@moon-0xff.github.com/
  '';

  passthru.extensionUuid = "mprisLabel@moon-0xff.github.com";

  meta = {
    description = "Display MPRIS media information in the GNOME top bar";
    homepage = "https://github.com/Moon-0xff/gnome-mpris-label";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
