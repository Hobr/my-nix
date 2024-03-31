{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        isort
        black
        flake8
        pip
        numbaWithCuda
        matplotlib
        cupy
        scipy
      ]))
    julia
  ];
}
