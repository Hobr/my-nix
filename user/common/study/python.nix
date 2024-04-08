{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        pip
        virtualenv
      ]))
  ];
}
