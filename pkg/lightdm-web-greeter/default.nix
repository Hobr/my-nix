{ lib, fetchFromGitHub, stdenv }:

stdenv.mkDerivation rec {
  pname = "lightdm-web-greeter";
  version = "3.5.2";

  src = fetchFromGitHub {
    owner = "JezerM";
    repo = "web-greeter";
    rev = version;
    fetchSubmodules = true;
    sha256 = "sha256-m20M4+3zsH40hTpMJG9cyIjXp0xcCUBS+cCiRVLXFqM=";
  };

  meta = with lib; {
    homepage = "https://github.com/JezerM/web-greeter";
    description = "A modern, visually appealing greeter for LightDM.";
    platforms = platforms.linux;
    license = licenses.gpl3;
  };
}
