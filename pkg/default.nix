pkgs: {
  rime-ice = pkgs.callPackage ./rime-ice { };
  azure-ai-translation-text = pkgs.callPackage ./azure-ai-translation-text { };
  pdf-math-translate = pkgs.callPackage ./pdf-math-translate {
    azure-ai-translation-text = pkgs.callPackage ./azure-ai-translation-text { };
  };
}
