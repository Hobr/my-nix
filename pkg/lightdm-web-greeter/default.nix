{ stdenv, fetchFromGitHub, ... } @ args:

stdenv.mkDerivation rec {
  pname = "lightdm-web-greeter";
  version = "3.5.2";

  src = fetchFromGitHub ({
    owner = "JezerM";
    repo = "web-greeter";
    rev = version;
    fetchSubmodules = true;
    sha256 = "sha256-m20M4+3zsH40hTpMJG9cyIjXp0xcCUBS+cCiRVLXFqM=";
  });

  enableParallelBuilding = true;
}
