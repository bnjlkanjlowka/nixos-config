(
  final: prev:
  let
    mk_proton-ge =
      { version, hash }:
      prev.proton-ge-bin.overrideAttrs (
        new: old: {
          __intentionallyOverridingVersion = true;
          steamDisplayName = version;
          pname = builtins.replaceStrings [ "GE-Proton" ] [ "proton-ge-" ] version;
          inherit version;

          passthru.variants = old.passthru.variants // {
            "x86_64-linux" = {
              toolName = "${version}-x86_64";
              src = final.fetchzip {
                url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}-x86_64.tar.gz";
                inherit hash;
              };
            };
          };
        }
      );
  in
  {
    proton-ge-11-5 = mk_proton-ge {
      version = "GE-Proton11-5";
      hash = "sha256-Sbyi5zXMhPIKSotvL5LEZ2dbDoLpXRcCyuY9TsnBnus=";
    };

    proton-ge-11-6 = mk_proton-ge {
      version = "GE-Proton11-6";
      hash = "sha256-rX27DUrrrHtR1cgyr/424m9JPjrdASIisVGv2vWzMAs=";
    };

    proton-ge-11-7 = mk_proton-ge {
      version = "GE-Proton11-7";
      hash = "sha256-ftW0vE45v2JsbaYqo/So0ZFfvdtakHX0XEXEE4TdxLk=";
    };

    proton-ge-11-10 = mk_proton-ge {
      version = "GE-Proton11-10";
      hash = "sha256-pR0MFuBcjr1RZOCJ9aDyWvadGDcXfpZt7loFSNFjWuU=";
    };

    proton-ge-11-11 = mk_proton-ge {
      version = "GE-Proton11-11";
      hash = "sha256-3tVgf83IkteFtVo/bHd4yG1xCtPeuW8FXaTrHOLjvKQ=";
    };
  }
)
