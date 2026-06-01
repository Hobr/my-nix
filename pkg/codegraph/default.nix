{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs,
}:

buildNpmPackage (finalAttrs: {
  pname = "codegraph";
  version = "0.9.8";

  src = fetchFromGitHub {
    owner = "colbymchenry";
    repo = "codegraph";
    tag = "v${finalAttrs.version}";
    hash = "sha256-DaVTUuaVsKS020HcIsD9R7jwxZw9yI1bgIsFOHyd/MY=";
  };

  npmDepsHash = "sha256-xNMl8aWbRicefSR1vXozGk5to+GXh/ihFK2V+HNfPdw=";

  inherit nodejs;
  dontNpmCheck = true;

  meta = {
    description = "Pre-indexed code knowledge graph for Claude Code, Codex, Cursor, and OpenCode";
    homepage = "https://github.com/colbymchenry/codegraph";
    changelog = "https://github.com/colbymchenry/codegraph/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "codegraph";
    platforms = lib.platforms.unix;
  };
})
