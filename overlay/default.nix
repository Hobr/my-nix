{ inputs, ... }:
{
  additions = final: _prev: import ../pkg final.pkgs;

  modifications = final: prev: {
    opencv4 = prev.opencv4.override {
      cudaPackages = prev.cudaPackages_12_3;
    };
    frei0r = prev.frei0r.override {
      cudaPackages = prev.cudaPackages_12_3;
    };
    mlt = prev.mlt.override {
      cudaPackages = prev.cudaPackages_12_3;
    };
  };
}
