{ stdenv, lib, srcFile, dstFile }:

let
  fs = lib.fileset;
  sourceFile = fs.unions [ ./${srcFile} ];
in

fs.trace sourceFile

stdenv.mkDerivation rec {
  name = "copy-${srcFile}";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFile;
  };
  buildInputs = [];
  installPhase = ''
    # Iterate over the filesToCopy object
    mkdir -p $out  # Create the root directory in the Nix store
    mkdir -p $out/$(dirname ${dstFile})
    cp ${srcFile} $out/${dstFile}
  '';
}
