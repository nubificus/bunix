let 
  # Define the CreateUruncJson function
  CreateUruncJson = { unikernelType, hypervisor, binary, cmdline, unikernelVersion, initrd, block, blkMntPoint }:
  let
    jsonContent = {
      "com.urunc.unikernel.binary"= binary;
      "com.urunc.unikernel.cmdline"= cmdline;
      "com.urunc.unikernel.unikernelType"= unikernelType;
      "com.urunc.unikernel.unikernelVersion"= unikernelVersion;
      "com.urunc.unikernel.hypervisor"= hypervisor;
      "com.urunc.unikernel.initrd"= initrd;
      "com.urunc.unikernel.block"= block;
      "com.urunc.unikernel.blkMntPoint"= blkMntPoint;
    };
  in
    builtins.toJSON jsonContent;

  # Call the function and create the JSON
  myFile = CreateUruncJson {
    unikernelType = "rumprun";
    hypervisor = "hvt";
    binary = "/unikernel/binary";
    cmdline = "Hello world";
    unikernelVersion = "";
    initrd = "";
    block = "";
    blkMntPoint = "";
  };
  
in
  myFile  # Return the result
