{
  lib,
  config,
  stdenv,
  fetchFromGitHub,
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
  useBundledLuaJIT ? false,
}:
assert spellcheckSupport -> (hunspell != null);
assert openalSupport -> (openal != null);
assert alsaSupport -> (alsa-lib != null);
assert pulseaudioSupport -> (libpulseaudio != null);
assert portaudioSupport -> (portaudio != null); let
  luajit52 = luajit.override {enable52Compat = true;};
  inherit (lib) optional;
in
  stdenv.mkDerivation rec {
    pname = "arch1t3cht";
    version = "future_11";

    src = fetchFromGitHub {
      owner = "wangqr";
      repo = pname;
      rev = version;
      sha256 = "";
    };

    nativeBuildInputs = [
      luajit52
      git
      meson
      boost
      wrapGAppsHook
    ];

    buildInputs =
      [
        boost
        ffmpeg
        ffms
        fftw
        fontconfig
        hicolor-icon-theme
        icu
        jansson
        libass
        libGL
        python3
        libuchardet
        vapoursynth
        vapoursynth-plugin-bestsource-git
        vapoursynth-plugin-lsmashsource
        vapoursynth-plugin-wwxd-git
        wxGTK32
        zlib
      ]
      ++ optional spellcheckSupport [hunspell hunspellDicts.en_US]
      ++ optional alsaSupport alsa-lib
      ++ optional openalSupport openal
      ++ optional portaudioSupport portaudio
      ++ optional pulseaudioSupport libpulseaudio;

    enableParallelBuilding = true;

    hardeningDisable = [
      "bindnow"
      "relro"
    ];

    patches = lib.optionals (!useBundledLuaJIT) [
      ./patch/remove-bundled-luajit.patch
    ];

    # error: unknown type name 'NSUInteger'
    postPatch = ''
      substituteInPlace src/dialog_colorpicker.cpp \
        --replace "NSUInteger" "size_t"
    '';

    env.NIX_CFLAGS_COMPILE = "-I${luajit52}/include";
    NIX_CFLAGS_LINK = "-L${luajit52}/lib";

    configurePhase = ''
      export FORCE_GIT_VERSION=${version}
      # Workaround for a Nixpkgs bug; remove when the fix arrives
      mkdir build-dir
      cd build-dir
      cmake -DCMAKE_INSTALL_PREFIX=$out ..
    '';

    meta = with lib; {
      homepage = "https://github.com/wangqr/Aegisub";
      description = " 	A general-purpose subtitle editor with ASS/SSA support (arch1t3cht fork)";
      license = licenses.bsd3;
      maintainers = with maintainers; [tgoyne kblomster arch1t3cht];
      platforms = platforms.unix;
      mainProgram = "aegisub";
    };
  }
