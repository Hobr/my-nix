{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rime-ice";
  version = "2024-04-02 12:40";
  src = fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "ab648212584a5e54bf72583ba729e9d82c7f4888";
    hash = "sha256-n/89Os25hAJRjIwqfgmUCHigIWDOQ4V6DPIlv6xYBzk=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    cp -r * $out/share/rime-data/
  '';

  meta = with lib; {
    description = "Rime 配置：雾凇拼音 | 长期维护的简体词库 ";
    homepage = "https://dvel.me/posts/rime-ice/";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
