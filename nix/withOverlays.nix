{ inputs, outputs, ... }:
[
  outputs.overlays.modifications
  inputs.nix-vscode-extensions.overlays.default
  inputs.chinese-fonts-overlay.overlays.default
  inputs.llm-agents.overlays.shared-nixpkgs
]
