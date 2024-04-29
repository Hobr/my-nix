{ pkgs, ... }: {
  home.packages = with pkgs; [
    poetry

    (python3.withPackages
      (python-pkgs: with python-pkgs; [ pip isort black flake8 virtualenv ]))
  ];
}
