{ unikernelType, hypervisor, binary, cmdline, unikernelVersion ? "", initrd ? "", block ? "", blkMntPoint ? "" , useDMBlock ? "" }:

{
  "\"com.urunc.unikernel.binary\""= "\"${binary}\"";
  "\"com.urunc.unikernel.cmdline\""= "\"${cmdline}\"";
  "\"com.urunc.unikernel.unikernelType\""= "\"${unikernelType}\"";
  "\"com.urunc.unikernel.unikernelVersion\""= "\"${unikernelVersion}\"";
  "\"com.urunc.unikernel.hypervisor\""= "\"${hypervisor}\"";
  "\"com.urunc.unikernel.initrd\""= "\"${initrd}\"";
  "\"com.urunc.unikernel.block\""= "\"${block}\"";
  "\"com.urunc.unikernel.blkMntPoint\""= "\"${blkMntPoint}\"";
  "\"com.urunc.unikernel.useDMBlock\""= "\"${useDMBlock}\"";
}
