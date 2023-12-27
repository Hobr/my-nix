{inputs,...}:
{
  imports = [inputs.nh.nixosModules.default];
  nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 5";
  };
}
