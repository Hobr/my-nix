{ ... }@pkgs:
let
  packagePath = pkgs.path + "/pkgs/by-name/zo/zotero/package.nix";
  package = builtins.readFile packagePath;
  package10_0_2 =
    builtins.replaceStrings
      [
        ''version = "10.0.1";''
        "sha256-ySFz91WD1KW2V0PETnMQLPm8Og69nbvlpmkf0PHWTQQ="
        "./pdf-reader-locales.patch"
        "./pdf-reader-build-fix.patch"
        "./avoid-git.patch"
        "./js-build-fixes.patch"
        "./avoid-xulrunner-fetch.patch"
        "./build-fixes.patch"
      ]
      [
        ''version = "10.0.2";''
        "sha256-V0dYKFWr1ZjYNEWufslW/NqfjPZOb8W1pECz33PcCEQ="
        "${pkgs.path}/pkgs/by-name/zo/zotero/pdf-reader-locales.patch"
        "${pkgs.path}/pkgs/by-name/zo/zotero/pdf-reader-build-fix.patch"
        "${pkgs.path}/pkgs/by-name/zo/zotero/avoid-git.patch"
        "${pkgs.path}/pkgs/by-name/zo/zotero/js-build-fixes.patch"
        "${pkgs.path}/pkgs/by-name/zo/zotero/avoid-xulrunner-fetch.patch"
        "${pkgs.path}/pkgs/by-name/zo/zotero/build-fixes.patch"
      ]
      package;
  zotero = pkgs.callPackage (builtins.toFile "zotero.nix" package10_0_2) { inherit zotero; };
in
zotero
