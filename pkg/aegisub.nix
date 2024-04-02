{
  lib,
  config,
  stdenv,
  fetchFromGitHub,
  git,
  meson,
  ninja,
  cmake,
  pkg-config,
  boost,
  ffmpeg,
  fontconfig,
  libass,
  ffms,
  fftw,
  hicolor-icon-theme,
  icu,
  zlib,
  jansson,
  wxGTK32,
  libuchardet,
  spellcheckSupport ? true,
  hunspell ? null,
  openalSupport ? false,
  openal ? null,
  alsaSupport ? stdenv.isLinux,
  alsa-lib ? null,
  pulseaudioSupport ? config.pulseaudio or stdenv.isLinux,
  libpulseaudio ? null,
  portaudioSupport ? false,
  portaudio ? null,
}:
assert spellcheckSupport -> (hunspell != null);
assert alsaSupport -> (alsa-lib != null);
assert openalSupport -> (openal != null);
assert portaudioSupport -> (portaudio != null);
assert pulseaudioSupport -> (libpulseaudio != null); let
  inherit (lib) optional;
in
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
      git
      meson
      ninja
      cmake
      pkg-config
      boost
    ];

    buildInputs =
      [
        boost
        ffmpeg
        fontconfig
        libass
        ffms
        fftw
        hicolor-icon-theme
        icu
        jansson
        zlib
        wxGTK32
        libuchardet
      ]
      ++ optional spellcheckSupport hunspell
      ++ optional alsaSupport alsa-lib
      ++ optional openalSupport openal
      ++ optional portaudioSupport portaudio
      ++ optional pulseaudioSupport libpulseaudio;

    enableParallelBuilding = true;

    meta = with lib; {
      description = "Cross-platform advanced subtitle editor, with new feature branches. Read the README on the feature branch";
      homepage = "https://github.com/arch1t3cht/Aegisub";
      license = licenses.bsd3;
      maintainers = with maintainers; [];
      mainProgram = "aegisub";
      platforms = platforms.all;
    };
  }
