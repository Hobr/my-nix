{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchPnpmDeps,
  makeWrapper,
  nodejs,
  pnpm_10,
  pnpmConfigHook,
  versionCheckHook,
  nix-update-script,
}:

let
  pnpm = pnpm_10;

  pnpmWorkspaces = [
    "@mindfoldhq/trellis-core"
    "@mindfoldhq/trellis"
  ];
in
stdenv.mkDerivation (finalAttrs: {
  pname = "trellis";
  version = "0.6.5";

  src = fetchFromGitHub {
    owner = "mindfold-ai";
    repo = "trellis";
    rev = "v${finalAttrs.version}";
    hash = "sha256-GX9EnmiCC+jTupx/Ahjmfkt/Ct3YAnu9UERVhv4tuTg=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit pnpm pnpmWorkspaces;
    hash = "sha256-DFPIIQbxJpN6FTcOUBEWu5E5lEotGX2eqzIlieTMlyY=";
    fetcherVersion = 3;
  };

  inherit pnpmWorkspaces;

  nativeBuildInputs = [
    makeWrapper
    nodejs
    pnpm
    pnpmConfigHook
  ];

  buildPhase = ''
    runHook preBuild

    pnpm --filter @mindfoldhq/trellis-core build
    pnpm --filter @mindfoldhq/trellis build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    pnpm config set inject-workspace-packages true
    pnpm --filter @mindfoldhq/trellis --prod --ignore-scripts deploy $out/lib/trellis

    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/trellis \
      --add-flags $out/lib/trellis/bin/trellis.js \
      --prefix PATH : ${lib.makeBinPath [ nodejs ]}
    ln -s $out/bin/trellis $out/bin/tl

    runHook postInstall
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "An out-of-the-box engineering framework for AI coding.";
    homepage = "https://github.com/mindfold-ai/trellis";
    changelog = "https://github.com/mindfold-ai/trellis/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "trellis";
    platforms = lib.platforms.all;
  };
})
