{ inputs, ... }:
{
  modifications = _final: prev: {
    hyprland = prev.hyprland.override {
      withUWSM = false;
    };
  };
}
