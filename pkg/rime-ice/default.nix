{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "rime-ice";
  version = "unstable-2025-03-11";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "75b225e84f5e95ddf0b5a50fa6e2cff9800ee7b7";
    hash = "sha256-/sKoufIf4m5h1Zds6AqIyeCjDaZsFU9ot5ln3ykuNyU=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    cp -r * $out/share/rime-data/
  '';

  meta = {
    description = "Rime 配置：雾凇拼音 | 长期维护的简体词库";
    homepage = "https://github.com/iDvel/rime-ice";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "rime-ice";
    platforms = lib.platforms.all;
  };
}
