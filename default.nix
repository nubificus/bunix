# default.nix
{ nixpkgs ? import <nixpkgs> {} }:

let
  stdenv = nixpkgs.stdenv;
  uruncJSON = ./uruncJSON.nix;
  argsFile = ./args.nix;
in

  # Call the generate-json.nix derivation
  import ./createUruncJSON.nix {
    inherit stdenv uruncJSON argsFile;
  }
