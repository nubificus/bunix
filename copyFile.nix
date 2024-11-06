{ stdenv, srcFile, dstFile }:

stdenv.mkDerivation rec {
  name = "copy-${srcFile}";
  src = ./.;
  dontUnpack = true;
  buildInputs = [];
  installPhase = ''
    # Iterate over the filesToCopy object
    mkdir -p $out  # Create the root directory in the Nix store
    mkdir -p $out/$(dirname ${dstFile})
    cp ${src}/${srcFile} $out/${dstFile}
  '';
}
