# args.nix
{
  files = {
    ".//hello.hvt" = "/unikernel/hello.hvt";
  };
  annotations = {
    unikernelType = "rumprun";
    hypervisor = "hvt";
    binary = "/unikernel/hello.hvt";
    cmdline = "hello";
    unikernelVersion = "";
    initrd = "";
    block = "";
    blkMntPoint = "";
  };
}
