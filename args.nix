# args.nix
{
  unikernelType = "rumprun";
  hypervisor = "hvt";
  binary = "/unikernel/hello.hvt";
  cmdline = "hello";
  unikernelVersion = "";
  initrd = "";
  block = "";
  blkMntPoint = "";
}
