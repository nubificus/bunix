with import <nixpkgs> {};

let 
  # Define the CreateUruncJson function
  CreateUruncJson = { unikernelType, hypervisor, binary, cmdline, unikernelVersion, initrd, block, blkMntPoint }:
  let
    jsonContent = {
      "\"com.urunc.unikernel.binary\""= "\"${binary}\"";
      "\"com.urunc.unikernel.cmdline\""= "\"${cmdline}\"";
      "\"com.urunc.unikernel.unikernelType\""= "\"${unikernelType}\"";
      "\"com.urunc.unikernel.unikernelVersion\""= "\"${unikernelVersion}\"";
      "\"com.urunc.unikernel.hypervisor\""= "\"${hypervisor}\"";
      "\"com.urunc.unikernel.initrd\""= "\"${initrd}\"";
      "\"com.urunc.unikernel.block\""= "\"${block}\"";
      "\"com.urunc.unikernel.blkMntPoint\""= "\"${blkMntPoint}\"";
    };
    jsonString = builtins.toJSON jsonContent;
    # Create a file with the JSON string using writeText
  in
    stdenv.mkDerivation rec {
      name = "urunc.json";
      src = null;
      dontUnpack = true;
      buildInputs = [ pkgs.coreutils ];
      installPhase = ''
        mkdir -p $out
        echo "${jsonString}" > $out/urunc.json
      '';
    };
in
  # Call the function and create the JSON
  CreateUruncJson {
    unikernelType = "rumprun";
    hypervisor = "hvt";
    binary = "/unikernel/binary";
    cmdline = "Hello world";
    unikernelVersion = "";
    initrd = "";
    block = "";
    blkMntPoint = "";
  }
