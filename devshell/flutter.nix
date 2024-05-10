{
  description = "Android Shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };

        androidEnv = pkgs.androidenv.override { licenseAccepted = true; };
        androidComposition = androidEnv.composeAndroidPackages {
          cmdLineToolsVersion = "8.0";
          platformToolsVersion = "34.0.4";
          buildToolsVersions = [ "34.0.0" ];
          platformVersions = [
            "28"
            "34"
          ];
          abiVersions = [ "x86_64" ];
          includeNDK = true;
          includeSystemImages = true;
          systemImageTypes = [
            "google_apis"
            "google_apis_playstore"
          ];
          includeEmulator = true;
          useGoogleAPIs = true;
          useGoogleTVAddOns = false;
          extraLicenses = [
            "android-googletv-license"
            "android-sdk-arm-dbt-license"
            "android-sdk-license"
            "android-sdk-preview-license"
            "google-gdk-license"
            "intel-android-extra-license"
            "intel-android-sysimage-license"
            "mips-android-sysimage-license"
          ];
        };
        androidSdk = androidComposition.androidsdk;
      in
      {
        devShell =
          with pkgs;
          mkShell rec {
            buildInputs = [
              androidSdk
              jdk20
              gradle
              flutter
            ];
            PUB_HOSTED_URL = "https://pub.flutter-io.cn";
            FLUTTER_STORAGE_BASE_URL = "https://storage.flutter-io.cn";
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            JAVA_HOME = jdk20.home;
            FLUTTER_ROOT = flutter;
            DART_ROOT = "${flutter}/bin/cache/dart-sdk";
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";
            QT_QPA_PLATFORM = "wayland;xcb";
            LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
              vulkan-loader
              libGL
            ]}";
            shellHook = ''
              if [ -z "$PUB_CACHE" ]; then
                export PATH="$PATH:$HOME/.pub-cache/bin"
              else
                export PATH="$PATH:$PUB_CACHE/bin"
              fi
            '';
          };
      }
    );
}
