# Package unikernels as containers for urunc with Nix

This repository contains all the necessary files to package unikernels as
container images that can be deployed in
[urunc](https://github.com/nubificus/urunc).

## Requirements

Since the packaging take place with Nix, we need to install [Nix package
manger](https://nixos.wiki/wiki/Nix_package_manager) or run it
[NixOS](https://nixos.org/). For up-to-date instructions on installing Nix
package manger, please check [here](https://nixos.org/download/). According to
that page, a (recommended) multi-user installation can take place with the following command.
```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## Usage guide

After installing Nix packages, a user can package `urunc` containers simply
with:
```
nix-build default.nix
```

The above command will create a Docker image tar using the information in
`args.nix` file. In particular, the `args.nix` file has the following fields:
- name: The name of the final container image
- tag: The tag of the final container image
- files: A list of local files to copy inside the container's rootFS. Every
  entry has a key, which is the path to the local file (relative to CWD) and a
  value, which is the path inside the container rootfs, where the file will be
  placed.
- annotations: A list of all annotations that `urunc` supports.

For exmaple the default content of `args.nix` is the following one:
```
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
```

Therefore, the Nix build will:
1. Copy the file `hello.hvt` in CWD inside container;s rootfs under
   `/unikernel/hello.hvt`.
2. Setup the `urunc` annotations, creating a `urunc.json` file inside the
   container rootfs.
3. It will name the final container image after the `hello-rumprun` name and
   it will tag it with the tag `latest`.

When running `nix-build` the output will be a Docker image tar file in the Nix
store. Nix by default, wil lalso create a symlink, called `result` in our CWD
poinitng to the respctive path in the Nix store.

We can load the Docker image with:
```
docker load < result
```
