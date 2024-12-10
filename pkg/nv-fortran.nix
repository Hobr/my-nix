{
  lib,
  stdenv,
  fetchurl,
  glibc,
  libstdcxx,
  patchelf,
}:

stdenv.mkDerivation rec {
  pname = "nv-hpc";
  version = "2411";

  src = fetchurl {
    url = "https://developer.download.nvidia.com/hpc-sdk/24.11/nvhpc_2024_2411_Linux_x86_64_cuda_12.6.tar.gz";
    sha256 = "";
  };

  nativeBuildInputs = [ patchelf ];

  buildInputs = [
    glibc
    libstdcxx
  ];

  unpackPhase = "tar xpzf $src";

  installPhase = ''
    mkdir -p $out
    ./install --prefix=$out --silent
    patchelf --set-rpath $out/Linux_x86_64/$version/compilers/lib $out/Linux_x86_64/$version/compilers/bin/nvfortran
  '';

  postInstall = ''
    echo 'export PATH=$out/Linux_x86_64/$version/compilers/bin:$PATH' >> $out/setup.sh
    echo 'export LD_LIBRARY_PATH=$out/Linux_x86_64/$version/compilers/lib:$LD_LIBRARY_PATH' >> $out/setup.sh
  '';

  meta = with lib; {
    description = "NV HPC SDK";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
