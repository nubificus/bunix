{ stdenv, uruncJSON, argsFile, nixpkgs ? import <nixpkgs> {} }:

let
  lib = nixpkgs.lib;
  args = import argsFile;
  jsonCreator = import uruncJSON;
  jsonContent = jsonCreator args;
  jsonString = builtins.toJSON jsonContent;
in

stdenv.mkDerivation rec {
  name = "urunc.json";
  src = null;
  dontUnpack = true;
  buildInputs = [ ];
  installPhase = ''
    mkdir -p $out
    echo "${jsonString}" > $out/urunc.json
  '';
}
