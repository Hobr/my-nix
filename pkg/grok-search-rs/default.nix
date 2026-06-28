{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "grok-search-rs";
  version = "0.1.17";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "Episkey-G";
    repo = "GrokSearch-rs";
    tag = "v${finalAttrs.version}";
    hash = "sha256-wvoUNoQfFFkxIgJlyXmHwBQ38U5KPkpAGX/GMw6KyLo=";
  };

  cargoHash = "sha256-fr+PPNARQhS9d3kCyFWBXnRZm4ZtdXAopkG76zYPHGo=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Rust MCP server for Grok web search and Tavily-backed source retrieval";
    homepage = "https://github.com/Episkey-G/GrokSearch-rs";
    changelog = "https://github.com/Episkey-G/GrokSearch-rs/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "grok-search-rs";
  };
})
