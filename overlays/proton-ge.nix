(final: prev: {
  proton-ge-11-6 = prev.proton-ge-bin.overrideAttrs (
    new: old: {
      steamDisplayName = "GE-Proton11-6";
      pname = "proton-ge-11-6";
      version = "GE-Proton11-6";

      passthru.variants = old.passthru.variants // {
        "x86_64-linux" = {
          toolName = "${new.version}-x86_64";
          src = final.fetchzip {
            url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${new.version}/${new.version}-x86_64.tar.gz";
            hash = "sha256-rX27DUrrrHtR1cgyr/424m9JPjrdASIisVGv2vWzMAs=";
          };
        };
      };
    }
  );
})
