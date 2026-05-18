{
  lib,
  stdenv,
  fetchurl,
  nodejs,
  makeWrapper,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "auggie";
  version = "0.27.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/@augmentcode/auggie/-/auggie-${finalAttrs.version}.tgz";
    hash = "sha256-kBn0ghkevIh/yfnaymo5Gbh1JtrwWFEO7QUnNQCEKgM=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 augment.mjs   $out/lib/auggie/augment.mjs
    install -Dm644 package.json  $out/lib/auggie/package.json
    install -Dm644 LICENSE.md    $out/lib/auggie/LICENSE.md
    install -Dm644 README.md     $out/lib/auggie/README.md

    makeWrapper ${lib.getExe nodejs} $out/bin/auggie \
      --add-flags $out/lib/auggie/augment.mjs

    runHook postInstall
  '';

  meta = {
    description = "Auggie CLI Client by Augment Code";
    homepage = "https://augmentcode.com";
    license = lib.licenses.unfree;
    mainProgram = "auggie";
    platforms = lib.platforms.unix;
  };
})
