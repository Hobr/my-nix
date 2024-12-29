{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rime-ice";
  version = "2024.12.28";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "main";
    hash = "sha256-tFeGkY0sg3ZmrDidIC9MRndQQnCLPtimkKZ6FwUq2Is=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    cp -r * $out/share/rime-data/
  '';

  meta = with lib; {
    description = "Rime 配置：雾凇拼音 | 长期维护的简体词库";
    homepage = "https://github.com/iDvel/rime-ice";
    license = licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "rime-ice";
    platforms = platforms.all;
  };
}
