{
  lib,
  python3Packages,
  fetchFromGitHub,
  nix-update-script,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "zotero-mcp-server";
  version = "0.5.0";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "54yyyu";
    repo = "zotero-mcp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ioy6bdP+jFioUGBKiiYtD4nbdFe6v2E3nCi6s9+dTT0=";
  };

  build-system = [
    python3Packages.hatchling
  ];

  dependencies = with python3Packages; [
    bibtexparser
    fastmcp
    markitdown
    mcp
    pydantic
    python-dotenv
    pyzotero
    requests
    unidecode

    ebooklib
    pymupdf
    requests
    chromadb
    google-genai
    openai
    sentence-transformers
    tiktoken
  ];

  pythonImportsCheck = [
    "zotero_mcp"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Zotero MCP: Connects your Zotero research library with Claude and other AI assistants via the Model Context Protocol to discuss papers, get summaries, analyze citations, and more";
    homepage = "https://github.com/54yyyu/zotero-mcp";
    changelog = "https://github.com/54yyyu/zotero-mcp/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
  };
})
