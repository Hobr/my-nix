{
  lib,
  python3,
  fetchPypi,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "azure-ai-translation-text";
  version = "1.0.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-j/839+pPgvJa1jKDdIWda60CLS8w/emzC17kzx98F2k=";
  };

  build-system = with python3.pkgs; [
    setuptools
    wheel
  ];

  dependencies = with python3.pkgs; [
    isodate
    azure-core
    typing-extensions
  ];

  meta = {
    description = "Microsoft Azure Ai Translation Text Client Library for Python";
    homepage = "https://pypi.org/project/azure-ai-translation-text/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "azure-ai-translation-text";
  };
}
