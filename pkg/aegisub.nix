{
  lib,
  config,
  stdenv,
  fetchFromGitHub,
  boost179,
  cmake,
  expat,
  harfbuzz,
  ffmpeg,
  ffms,
  fftw,
  fontconfig,
  freetype,
  fribidi,
  glib,
  icu,
  intltool,
  libGL,
  libGLU,
  libX11,
  libass,
  libiconv,
  libuchardet,
  luajit,
  pcre,
  pkg-config,
  which,
  wrapGAppsHook,
  wxGTK,
  zlib,
  meson,
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
  darwin,
}:
assert spellcheckSupport -> (hunspell != null);
assert openalSupport -> (openal != null);
assert alsaSupport -> (alsa-lib != null);
assert pulseaudioSupport -> (libpulseaudio != null);
assert portaudioSupport -> (portaudio != null); let
  luajit52 = luajit.override {enable52Compat = true;};
  inherit (lib) optional;
  inherit (darwin.apple_sdk.frameworks) CoreText CoreFoundation AppKit Carbon IOKit Cocoa;
in
  stdenv.mkDerivation rec {
    pname = "Aegisub";
    version = "3.2.2";

    src = fetchFromGitHub {
      owner = "arch1t3cht";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-oKhLv81EFudrJaaJ2ga3pVh4W5Hd2YchpjsoYoqRm78=";
    };

    nativeBuildInputs = [
      intltool
      luajit52
      pkg-config
      which
      wrapGAppsHook
      meson
    ];

    buildInputs =
      [
        boost179
        expat
        ffmpeg
        ffms
        fftw
        fontconfig
        freetype
        fribidi
        glib
        harfbuzz
        icu
        libGL
        libGLU
        libX11
        libass
        libiconv
        libuchardet
        pcre
        wxGTK
        zlib
      ]
      ++ lib.optionals stdenv.isDarwin [
        CoreText
        CoreFoundation
        AppKit
        Carbon
        IOKit
        Cocoa
      ]
      ++ optional alsaSupport alsa-lib
      ++ optional openalSupport openal
      ++ optional portaudioSupport portaudio
      ++ optional pulseaudioSupport libpulseaudio
      ++ optional spellcheckSupport hunspell;

    enableParallelBuilding = true;

    hardeningDisable = [
      "bindnow"
      "relro"
    ];

    patches = lib.optionals (!useBundledLuaJIT) [
      ./remove-bundled-luajit.patch
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
      homepage = "https://github.com/arch1t3cht/Aegisub";
      description = "A general-purpose subtitle editor with ASS/SSA support (arch1t3cht fork)";
      license = licenses.bsd3;
      maintainers = with maintainers; [tgoyne kblomster arch1t3cht];
      platforms = platforms.unix;
      mainProgram = "aegisub";
    };
  }
