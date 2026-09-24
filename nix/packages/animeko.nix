{
  appimageTools,
  fetchurl,
  lib,
}:
let
  pname = "animeko";
  version = "6.1.0";
  src = fetchurl {
    url = "https://github.com/open-ani/animeko/releases/download/v${version}/ani-${version}-linux-x86_64.appimage";
    hash = "sha256-q+6rAdr0oIqxzXxNnGmZsXQaV32TrX4u8ouA6hIpaqc=";
  };
  contents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm644 ${contents}/icon.png $out/share/icons/hicolor/512x512/apps/animeko.png
    install -Dm644 ${contents}/animeko.desktop $out/share/applications/animeko.desktop
    substituteInPlace $out/share/applications/animeko.desktop \
      --replace-fail 'Exec=Ani' 'Exec=animeko' \
      --replace-fail 'Icon=icon' 'Icon=animeko'
  '';

  meta = {
    description = "One-stop platform for finding, following and watching anime";
    homepage = "https://github.com/open-ani/animeko";
    license = lib.licenses.agpl3Plus;
    mainProgram = "animeko";
    platforms = [ "x86_64-linux" ];
  };
}
