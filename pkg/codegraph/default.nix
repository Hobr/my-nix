{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs,
}:

buildNpmPackage (finalAttrs: {
  pname = "codegraph";
  version = "0.9.4";

  src = fetchFromGitHub {
    owner = "colbymchenry";
    repo = "codegraph";
    tag = "v${finalAttrs.version}";
    hash = "sha256-tJgpy1qyG7sSAIATTpVy9qgOoxf1K4J3dAh2xhTHgS8=";
  };

  npmDepsHash = "sha256-GJfqzykgrgD/KCtf8LupRw31S2cCmwGCF/0PMpzaCrk=";

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
