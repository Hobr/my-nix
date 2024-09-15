{ inputs, ... }:
{
  modifications = self: super: {
    opencv4 = super.opencv4.override {
      cudaPackages = super.cudaPackages_12_3;
    };
    frei0r = super.frei0r.override {
      cudaPackages = super.cudaPackages_12_3;
    };
    mlt = super.mlt.override {
      cudaPackages = super.cudaPackages_12_3;
    };
  };
}
