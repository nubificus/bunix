{ stdenv, uruncJSON, argsFile, createUruncJSON, copyFiles, nixpkgs ? import <nixpkgs> {} }:

let
  args = import argsFile;
  annotations = args.annotations;
  filesToCopy = args.files;
  pkgs = nixpkgs.pkgs;
  uruncJsonFile = import createUruncJSON {
    inherit stdenv uruncJSON annotations;
  };
  lib = nixpkgs.lib;
  userFiles = lib.mapAttrsToList (srcFile: dstFile: import copyFiles {
    inherit stdenv srcFile dstFile;
  }) filesToCopy;
  #userFiles = import copyFiles {
  #  inherit stdenv lib filesToCopy;
  #};
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
    userFiles
  ];
  config = {
    Cmd = [ "unikernel" ];
  };
}
