{ stdenv, uruncJSON, argsFile, createUruncJSON, nixpkgs ? import <nixpkgs> {} }:

let
  uruncJsonFile = import createUruncJSON {
    inherit stdenv uruncJSON argsFile;
  };
  pkgs = nixpkgs.pkgs;
  # createLayer = file: pkgs.dockerTools.buildLayer rec {
  #   fromImage = "scratch";  # Start from scratch (empty image)
  #   contents = [ file ];  # Only add this file to the layer
  #   layerName = "urunc.json";  # Name the layer based on the file name
  # };
in

pkgs.dockerTools.buildImage {
  name = "hello-docker";
  tag = "trela";
  copyToRoot = [
    uruncJsonFile
  ];
  config = {
    Cmd = [ "/hello" ];
  };
}
