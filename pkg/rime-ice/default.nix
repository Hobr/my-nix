{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rime-ice";
  version = "2024.09.25";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "2024.09.25";
    hash = "sha256-R2K2LNycXqsUxXvMMq5fcQJUhDnhQMcTlvryMLeiKH0=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    cp -r * $out/share/rime-data/
  '';

  meta = with lib; {
    description = "Rime 配置：雾凇拼音 | 长期维护的简体词库";
    homepage = "https://github.com/iDvel/rime-ice";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
