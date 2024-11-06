# default.nix
{ nixpkgs ? import <nixpkgs> {} }:

let
  stdenv = nixpkgs.stdenv;
  uruncJSON = ./uruncJSON.nix;
  createUruncJSON = ./createUruncJSON.nix;
  argsFile = ./args.nix;
in

  # Call the generate-json.nix derivation
  import ./packContainer.nix {
    inherit stdenv uruncJSON argsFile createUruncJSON;
  }
