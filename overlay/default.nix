{ inputs, ... }:
{
  modifications = final: prev: {
    opencv_cuda = prev.opencv.overrideAttrs (oldAttrs: rec {
      cudaPackages = final.cudaPackages_12_3;
    });
  };
}
