{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs,
}:

buildNpmPackage (finalAttrs: {
  pname = "codegraph";
  version = "0.9.5";

  src = fetchFromGitHub {
    owner = "colbymchenry";
    repo = "codegraph";
    tag = "v${finalAttrs.version}";
    hash = "sha256-iHas8IxU6723INXcvSeefc1BMSnRxxdeaYifKu/N0HU=";
  };

  npmDepsHash = "sha256-P1FfBBbiQPi5XX2oqpLyuSgz2ThG1VWufK6sRd5rXPc=";

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
