{ stdenv, uruncJSON, argsFile, nixpkgs ? import <nixpkgs> {} }:

let
  lib = nixpkgs.lib;
  args = import argsFile;
  jsonCreator = import uruncJSON;
  jsonContent = jsonCreator args;
  jsonString = builtins.toJSON jsonContent;
  jq = nixpkgs.pkgs.jq;
in

stdenv.mkDerivation rec {
  name = "urunc.json";
  src = null;
  dontUnpack = true;
  buildInputs = [ jq ];
  installPhase = ''
    mkdir -p $out
    echo "${jsonString}" > $out/temp.json
    jq '. | map_values(@base64)' $out/temp.json > $out/urunc.json
  '';
}
