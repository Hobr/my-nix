{ pkgsFor, ... }:
{
  formatter = builtins.mapAttrs (_: pkgs: pkgs.nixfmt-tree) pkgsFor;
}
