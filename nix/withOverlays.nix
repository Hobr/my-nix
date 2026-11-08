{ inputs, outputs, ... }:
[
  inputs.nix-vscode-extensions.overlays.default
  inputs.chinese-fonts-overlay.overlays.default
  inputs.llm-agents.overlays.shared-nixpkgs
  outputs.overlays.modifications
]
