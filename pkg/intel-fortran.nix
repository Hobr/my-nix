{
  lib,
  stdenv,
  fetchurl,
  glibc,
  patchelf,
  ncurses,
}:

stdenv.mkDerivation rec {
  pname = "intel-fortran-essentials";
  version = "2025.0.0.301";

  src = fetchurl {
    url = "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/fa3a8006-4f1b-4764-85e1-ae13538d791a/intel-fortran-essentials-2025.0.0.310_offline.sh";
    sha256 = "sha256-cg9FejNH5jcjS+pEqDJvF9rdTSDgqHtY9cBxUl70Wd0=";
  };

  unpackPhase = ":";

  nativeBuildInputs = [
    patchelf
    ncurses
  ];

  buildInputs = [ glibc ];

  installPhase = ''
    mkdir -p $out
    cp $src ./installer.sh
    chmod +x ./installer.sh
    ./installer.sh -a --action install --eula accept --install-dir=$out

    patchelf --set-rpath $out/compiler/lib/intel64 $out/compiler/bin/ifort
  '';

  postInstall = ''
    echo 'export PATH=$out/compiler/bin:$PATH' >> $out/setup.sh
    echo 'export LD_LIBRARY_PATH=$out/compiler/lib/intel64:$LD_LIBRARY_PATH' >> $out/setup.sh
  '';

  meta = with lib; {
    description = "Intel oneAPI HPC Toolkit";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
