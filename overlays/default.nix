[
  (final: prev: {
    gnomeExtensions = prev.gnomeExtensions // {
      mpris-label = final.callPackage ../packages/mpris-label.nix { };
    };
  })
]
