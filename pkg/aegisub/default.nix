{
  lib,
  config,
  stdenv,
  fetchFromGitHub,
  fetchurl,

  meson,
  cmake,
  fontconfig,
  gettext,
  luajit,
  ninja,
  pkg-config,
  wrapGAppsHook3,

  boost183,
  ffmpeg,
  ffms,
  fftw,
  icu,
  libass,
  libGL,
  libuchardet,
  libX11,
  vapoursynth-bestsource,
  wxGTK31,

  alsaSupport ? stdenv.isLinux,
  alsa-lib,
  openalSupport ? true,
  openal,
  portaudioSupport ? false,
  portaudio,
  pulseaudioSupport ? config.pulseaudio or stdenv.isLinux,
  libpulseaudio,
  spellcheckSupport ? true,
  hunspell,
}:
let
  AviSynthPlus = fetchFromGitHub {
    owner = "AviSynth";
    repo = "AviSynthPlus";
    rev = "v3.7.2";
    hash = "sha256-PNIrDRJNKWEBPEKlCq0nE6UW0prVswE6mW+Fi4ROTAc=";
    fetchSubmodules = true;
  };

  vapoursynth = fetchFromGitHub {
    owner = "vapoursynth";
    repo = "vapoursynth";
    rev = "R59";
    hash = "sha256-6w7GSC5ZNIhLpulni4sKq0OvuxHlTJRilBFGH5PQW8U=";
    fetchSubmodules = true;
  };

  gtest = fetchurl {
    url = "https://github.com/google/googletest/archive/release-1.8.1.zip";
    hash = "sha256-kngnwYPQFzTMXP74Xg/z9akv/mGI4NGOkJxe/r8ooMc=";
  };

  gtest_patch = fetchurl {
    url = "https://wrapdb.mesonbuild.com/v1/projects/gtest/1.8.1/1/get_zip";
    hash = "sha256-959f1G4JUHs/LgmlHqbrIAIO/+VDM19a7lnzDMjRWAU=";
  };

  lua = luajit.override {
    enable52Compat = true;
    packageOverrides =
      ps: with ps; [
        luafilesystem
        moonscript
      ];
  };
in
stdenv.mkDerivation rec {
  pname = "aegisub";
  version = "12";

  src = fetchFromGitHub {
    owner = "arch1t3cht";
    repo = "Aegisub";
    rev = "feature_${version}";
    hash = "sha256-P+0aUeFsjke3Jj/QtGJRdaS0negYSnhiuf5QCw2Of5Q=";
  };

  nativeBuildInputs = [
    meson
    cmake
    fontconfig
    gettext
    lua
    ninja
    pkg-config
    wrapGAppsHook3
  ];

  buildInputs =
    [
      boost183
      ffmpeg
      ffms
      fftw
      icu
      libass
      libGL
      libuchardet
      libX11
      vapoursynth-bestsource
      wxGTK31
    ]
    ++ lib.optionals alsaSupport [ alsa-lib ]
    ++ lib.optionals openalSupport [ openal ]
    ++ lib.optionals portaudioSupport [ portaudio ]
    ++ lib.optionals pulseaudioSupport [ libpulseaudio ]
    ++ lib.optionals spellcheckSupport [ hunspell ];

  patches = [
    # Fix unable to generate git_version.h
    ./0002-remove-git-version.patch
    # Fix meson unable exec python respack
    ./0003-respack-unable-run.patch
  ];

  mesonBuildType = "release";
  dontUseCmakeConfigure = true;

  mesonFlags = [
    (lib.mesonEnable "alsa" alsaSupport)
    (lib.mesonEnable "openal" openalSupport)
    (lib.mesonEnable "libpulse" pulseaudioSupport)
    (lib.mesonEnable "portaudio" portaudioSupport)
    (lib.mesonEnable "directsound" false)
    (lib.mesonEnable "xaudio2" false)
    (lib.mesonOption "default_audio_output" "auto")

    (lib.mesonEnable "ffms2" true)
    (lib.mesonEnable "avisynth" true)
    (lib.mesonEnable "bestsource" true)
    (lib.mesonEnable "vapoursynth" true)

    (lib.mesonEnable "fftw3" true)
    (lib.mesonEnable "hunspell" spellcheckSupport)
    (lib.mesonEnable "uchardet" true)
    (lib.mesonEnable "csri" true)
  ];

  preConfigure = ''
    cp -r --no-preserve=mode ${AviSynthPlus} subprojects/avisynth
    cp -r --no-preserve=mode ${vapoursynth} subprojects/vapoursynth

    mkdir subprojects/packagecache
    cp -r --no-preserve=mode ${gtest} subprojects/packagecache/gtest-1.8.1.zip
    cp -r --no-preserve=mode ${gtest_patch} subprojects/packagecache/gtest-1.8.1-1-wrap.zip

    for project in avisynth vapoursynth; do
      meson subprojects packagefiles --apply $project
    done
  '';

  meta = {
    description = "Cross-platform advanced subtitle editor, with new feature branches. Read the README on the feature branch";
    homepage = "https://github.com/arch1t3cht/Aegisub/tree/feature_12";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "aegisub";
    platforms = lib.platforms.all;
  };
}
