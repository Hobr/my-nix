{ inputs, outputs, ... }:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      kanade = import ../../home;
    };
  };
}
