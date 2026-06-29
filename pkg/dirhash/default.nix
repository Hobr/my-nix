{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  versioneer,
  scantree,
}:

buildPythonPackage rec {
  pname = "dirhash";
  version = "0.5.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-5gdg8Ksuk12MsIiSPqLGSSOY3KQs7Hhd93iYX9TNU4Y=";
  };

  build-system = [
    setuptools
    versioneer
  ];

  dependencies = [
    scantree
  ];

  pythonImportsCheck = [ "dirhash" ];

  meta = {
    description = "Python module and CLI for hashing of file system directories";
    homepage = "https://github.com/andhus/dirhash-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
