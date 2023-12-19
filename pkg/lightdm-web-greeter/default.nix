{ stdenv, fetchFromGitHub, ... } @ args:

stdenv.mkDerivation rec {
  pname = "lightdm-web-greeter-${version}";
  version = "0.7.1";

  src = fetchFromGitHub ({
    owner = "open-quantum-safe";
    repo = "liboqs";
    rev = version;
    fetchSubmodules = false;
    sha256 = "sha256-m20M4+3zsH40hTpMJG9cyIjXp0xcCUBS+cCiRVLXFqM=";
  });

  enableParallelBuilding = true;
}
