{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

let
  metadata = "ewogICAgInV1aWQiOiAibXByaXNMYWJlbEBtb29uLTB4ZmYuZ2l0aHViLmNvbSIsCiAgICAibmFtZSI6ICJNZWRpYSBMYWJlbCBhbmQgQ29udHJvbHMgKE1wcmlzIExhYmVsKSIsCiAgICAiZGVzY3JpcHRpb24iOiAiRGlzcGxheSBhIGxhYmVsIGluIHlvdXIgcGFuZWwgd2l0aCB0aGUgc29uZy90aXRsZS9hbGJ1bS9hcnRpc3QgaW5mb3JtYXRpb24gYXZhaWxhYmxlIGZyb20gYW4gbXByaXMgY29tcGF0aWJsZSBwbGF5ZXIuIFlvdSBjYW4gYWxzbyBjb250cm9sIHRoZSBwbGF5ZXIsIHJhaXNlL2xvd2VyIGl0cyB2b2x1bWUsIGN1c3RvbWl6ZSB0aGUgbGFiZWwsIGFuZCBhIGxvdCBtb3JlISBUaGlzIGV4dGVuc2lvbiB3b3JrcyB3aXRoIFNwb3RpZnksIFZsYywgUmh5dGhtYm94LCBGaXJlZm94LCBDaHJvbWl1bSwgYW5kIChwcm9iYWJseSkgYW55IE1QUklTIGNvbXBhdGlibGUgcGxheWVyLiIsCiAgICAidmVyc2lvbiI6IDQzLAogICAgInNoZWxsLXZlcnNpb24iOiBbICI0OSIsICI1MCIsICI1MSIgXSwKICAgICJ1cmwiOiAiaHR0cHM6Ly9naXRodWIuY29tL01vb24tMHhmZi9nbm9tZS1tcHJpcy1sYWJlbCIsCiAgICAic2V0dGluZ3Mtc2NoZW1hIjogIm9yZy5nbm9tZS5zaGVsbC5leHRlbnNpb25zLm1wcmlzLWxhYmVsIgp9Cg==";
in
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

    echo ${metadata} | base64 -d > $out/share/gnome-shell/extensions/mprisLabel@moon-0xff.github.com/metadata.json
  '';

  passthru.extensionUuid = "mprisLabel@moon-0xff.github.com";

  meta = {
    description = "Display MPRIS media information in the GNOME top bar";
    homepage = "https://github.com/Moon-0xff/gnome-mpris-label";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
