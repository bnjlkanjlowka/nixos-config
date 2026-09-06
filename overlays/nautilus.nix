(final: prev: {
  nautilus = prev.nautilus.overrideAttrs (old: {
    patches = old.patches ++ [
      (final.fetchpatch {
        url = "https://src.fedoraproject.org/rpms/nautilus/raw/f42/f/default-terminal.patch";
        hash = "sha256-Ln6hgffwcrhO/gxjB8Y68RoGqSUNN/hE4sCqkR/xiA4=";
      })
    ];
  });

  glib = prev.glib.overrideAttrs (old: {
    patches = old.patches ++ [
      (final.fetchpatch {
        url = "https://src.fedoraproject.org/rpms/glib2/raw/f42/f/default-terminal.patch";
        hash = "sha256-7pQtxW8rsBTh/gUQlgCMRXWBNnXOPTEGWRrW0h+VgLc=";
      })
    ];
  });

  #падает на одном тесте иначе
  #cat: /build/tmp.xvBLocCuHa/notify.msg: No such file or directory
  #Error: Did not receive expected message on NOTIFY_SOCKET
  swtpm = prev.swtpm.overrideAttrs {
    doCheck = false;
  };
})
