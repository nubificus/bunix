# args.nix
{
  unikernelType = "rumprun";
  hypervisor = "hvt";
  binary = "/unikernel/binary";
  cmdline = "Hello world";
  unikernelVersion = "";
  initrd = "";
  block = "";
  blkMntPoint = "";
}
