{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
}:
stdenv.mkDerivation rec {
  pname = "aegisub";
  version = "11";

  src = fetchFromGitHub {
    owner = "arch1t3cht";
    repo = "Aegisub";
    rev = "feature_${version}";
    hash = "sha256-yEXDwne+wros0WjOwQbvMIXk0UXV5TOoV/72K12vi/c=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with lib; {
    description = "Cross-platform advanced subtitle editor, with new feature branches. Read the README on the feature branch";
    homepage = "https://github.com/arch1t3cht/Aegisub";
    license = licenses.bsd3;
    maintainers = with maintainers; [tgoyne kblomster arch1t3cht];
    mainProgram = "aegisub";
    platforms = platforms.all;
  };
}
