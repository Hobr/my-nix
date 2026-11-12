{ inputs, outputs, ... }:
[
  inputs.nix-vscode-extensions.overlays.default
  inputs.chinese-fonts-overlay.overlays.default
  outputs.overlays.modifications
]
