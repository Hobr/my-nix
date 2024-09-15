{ inputs, ... }:
{
  modifications = self: super: {
    opencv = super.opencv.override {
      cudaPackages = super.cudaPackages_12_3;
    };
    frei0r = super.frei0r.override {
      cudaPackages = super.cudaPackages_12_3;
    };
  };
}
