{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs,
}:

buildNpmPackage (finalAttrs: {
  pname = "codegraph";
  version = "0.9.2";

  src = fetchFromGitHub {
    owner = "colbymchenry";
    repo = "codegraph";
    tag = "v${finalAttrs.version}";
    hash = "sha256-kmz2dmIvoJ/eGLsXSmGWb1jOhk+AIFIBeThi5dr8f8A=";
  };

  npmDepsHash = "sha256-KiRTc6jHqIZkL2H5s5solYsAhK2Z1+ImEvBKtA0CWNc=";

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
