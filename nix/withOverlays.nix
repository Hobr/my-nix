{ inputs, outputs, ... }:
[
  outputs.overlays.modifications
  outputs.overlays.stable-package
  inputs.nix-vscode-extensions.overlays.default
  inputs.llm-agents.overlays.shared-nixpkgs
]
