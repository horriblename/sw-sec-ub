# https://ryantm.github.io/nixpkgs/build-helpers/special/fhs-environments/
{pkgs ? import <nixpkgs> {}}:
(pkgs.buildFHSEnv {
  name = "temp";
  # packages for the main host arch
  targetPkgs = p: (with p; [
    gdb
    gcc
    xxd
  ]);
  # packages to be installed for all arch supported by host
  # (e.g. i686 and x86_64 on x86_64 machine)
  multiPkgs = p: (with p; [
    glibc_multi
  ]);
  # install 32-bit multiPkgs also in 64-bit env
  multiArch = true;
  runScript = "zsh";
}).env
