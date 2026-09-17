(final: prev: {
  proton-ge-11-5 = prev.proton-ge-bin.overrideAttrs (
    new: old: {
      steamDisplayName = "GE-Proton11-5";
      pname = "proton-ge-11-5";
      version = "GE-Proton11-5";

      passthru.variants = old.passthru.variants // {
        "x86_64-linux" = {
          toolName = "${new.version}-x86_64";
          src = final.fetchzip {
            url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${new.version}/${new.version}-x86_64.tar.gz";
            hash = "sha256-Sbyi5zXMhPIKSotvL5LEZ2dbDoLpXRcCyuY9TsnBnus=";
          };
        };
      };
    }
  );

  proton-ge-11-7 = prev.proton-ge-bin.overrideAttrs (
    new: old: {
      steamDisplayName = "GE-Proton11-7";
      pname = "proton-ge-11-7";
      version = "GE-Proton11-7";

      passthru.variants = old.passthru.variants // {
        "x86_64-linux" = {
          toolName = "${new.version}-x86_64";
          src = final.fetchzip {
            url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${new.version}/${new.version}-x86_64.tar.gz";
            hash = "sha256-ftW0vE45v2JsbaYqo/So0ZFfvdtakHX0XEXEE4TdxLk=";
          };
        };
      };
    }
  );
})
