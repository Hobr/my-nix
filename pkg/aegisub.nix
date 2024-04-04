{
  lib,
  config,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  cmake,
  pkg-config,
  git,
  fontconfig,
  libass,
  boost,
  wxGTK32,
  icu,
  ffms,
  fftw,
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
assert openalSupport -> (openal != null);
assert alsaSupport -> (alsa-lib != null);
assert pulseaudioSupport -> (libpulseaudio != null);
assert portaudioSupport -> (portaudio != null); let
  inherit (lib) optional;
  bestsource = fetchFromGitHub {
    owner = "vapoursynth";
    repo = "bestsource";
    rev = "R1";
    hash = "sha256-FTMHBnhp+vPXvrreTqcDNMI3zl69NNlF6lQO7XFWIvE=";
  };
  AviSynthPlus = fetchFromGitHub {
    owner = "AviSynth";
    repo = "AviSynthPlus";
    rev = "v3.7.3";
    hash = "sha256-v/AErktcegdrwxDbD0DZ/ZAxgaZmkZD+qxR3EPFsT08=";
  };
  vapoursynth = fetchFromGitHub {
    owner = "vapoursynth";
    repo = "vapoursynth";
    rev = "R66";
    hash = "sha256-WKVBmV0zbeaW3x/DphgIFANXz3hYmnxl8GLGGYjGZJg=";
  };
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

    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/video/aegisub/default.nix
    # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=aegisub-arch1t3cht-git
    # https://github.com/arch1t3cht/Aegisub/blob/feature/meson.build
    nativeBuildInputs = [
      meson
      ninja
      cmake
      pkg-config
      git
    ];

    buildInputs =
      [
        fontconfig
        libass
        boost
        wxGTK32
        icu
        ffms
        fftw
        libuchardet
      ]
      ++ optional alsaSupport alsa-lib
      ++ optional openalSupport openal
      ++ optional portaudioSupport portaudio
      ++ optional pulseaudioSupport libpulseaudio
      ++ optional spellcheckSupport hunspell;

    env = {
      BOOST_INCLUDEDIR = "${lib.getDev boost}/include";
      BOOST_LIBRARYDIR = "${lib.getLib boost}/lib";
    };

    # https://github.com/arch1t3cht/Aegisub/blob/feature/meson_options.txt
    # https://github.com/NixOS/nixpkgs/blob/8dab54e2b3c4d0c946e1a24cad6bf23e552b2b36/pkgs/development/libraries/gstreamer/ugly/default.nix#L68
    # https://github.com/NixOS/nixpkgs/blob/8dab54e2b3c4d0c946e1a24cad6bf23e552b2b36/pkgs/servers/pulseaudio/default.nix#L96
    mesonFlags = [
      # Test
      "-Dwrap_mode=nopromote"

      "--buildtype=release"
      (lib.mesonEnable "alsa" false)
      (lib.mesonEnable "openal" false)
      (lib.mesonEnable "libpulse" true)
      (lib.mesonEnable "portaudio" false)
      (lib.mesonEnable "directsound" false)
      (lib.mesonEnable "xaudio2" false)

      (lib.mesonOption "default_audio_output" "PulseAudio")

      (lib.mesonEnable "ffms2" true)
      (lib.mesonEnable "avisynth" true)
      (lib.mesonEnable "bestsource" true)
      (lib.mesonEnable "vapoursynth" true)

      (lib.mesonEnable "fftw3" true)
      (lib.mesonEnable "hunspell" true)
      (lib.mesonEnable "uchardet" true)
      (lib.mesonEnable "csri" true)
    ];

    enableParallelBuilding = true;

    # https://nix.dev/tutorials/packaging-existing-software.html
    configurePhase = ''
      runHook preInstall
      mkdir -p $out/subprojects/bestsource
      cp ${bestsource} subprojects/bestsource
      mkdir -p $out/subprojects/vapoursynth
      cp ${vapoursynth} subprojects/vapoursynth
      mkdir -p $out/subprojects/avisynth
      cp ${AviSynthPlus} subprojects/avisynth
      runHook postInstall
    '';

    meta = with lib; {
      description = "Cross-platform advanced subtitle editor, with new feature branches.";
      homepage = "https://github.com/arch1t3cht/Aegisub";
      license = licenses.bsd3;
      maintainers = with maintainers; [tgoyne kblomster arch1t3cht];
      mainProgram = "aegisub";
      platforms = platforms.all;
    };
  }
