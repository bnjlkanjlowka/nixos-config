(final: prev: {
  newsflash = prev.newsflash.overrideAttrs (
    new: old: {
      buildInputs = (old.buildInputs or [ ]) ++ [
        prev.aws-lc
      ];
    }
  );
})
