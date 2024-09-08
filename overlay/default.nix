{ inputs, ... }:
{
  modifications = final: prev: {
    cudaPackages = final.cudaPackages_12_3;
  };
}
