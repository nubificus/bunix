# args.nix
{
  name = "hello-rumprun";
  tag = "latest";
  files = {
    "./hello1.hvt" = "/unikernel/hello.hvt";
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
    useDMBlock = "";
  };
}
