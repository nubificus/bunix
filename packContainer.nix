{ stdenv, uruncJSON, argsFile, createUruncJSON, copyFiles, nixpkgs ? import <nixpkgs> {} }:

let
  pkgs = nixpkgs.pkgs;
  lib = nixpkgs.lib;
  args = import argsFile;
  annotations = args.annotations;
  filesToCopy = args.files;
  imageName = args.name;
  imageTag = args.tag;
  uruncJsonFile = import createUruncJSON {
    inherit stdenv uruncJSON annotations;
  };
  userFiles = lib.mapAttrsToList (srcFile: dstFile: import copyFiles {
    inherit stdenv lib srcFile dstFile;
  }) filesToCopy;
in

#pkgs.dockerTools.buildLayeredImage {
pkgs.dockerTools.buildImage {
  name = imageName;
  tag = imageTag;
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
