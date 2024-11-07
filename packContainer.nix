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
    inherit stdenv lib srcFile dstFile;
  }) filesToCopy;
in

#pkgs.dockerTools.buildLayeredImage {
pkgs.dockerTools.buildImage {
  name = "hello-docker";
  tag = "trela";
  #includeStorePaths = true;
  #contents = [
  copyToRoot = [
    uruncJsonFile
    userFiles
  ];
  created="now";
  compressor="none";
  config = {
    Cmd = [ "unikernel" ];
  };
}
