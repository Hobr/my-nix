{ inputs, ... }:
{
  additions = final: _prev: import ../pkg final.pkgs;

  modifications =
    final: prev:
    {
    };
}
