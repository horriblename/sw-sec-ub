{
  description = "A very basic flake";
  inputs = {
    dots.url = "github:horriblename/dots.nix";
    nixpkgs.follows = "dots/nixpkgs";
  };
  outputs = {
    self,
    dots,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    eachSystem = lib.genAttrs ["x86_64-linux"];
    pkgsFor = eachSystem (
      system:
        import nixpkgs {
          localSystem = system;
          overlays = [];
        }
    );
  in {
    packages = eachSystem (system: {
      inherit (dots.packages.${system}) pwndbg;
    });

    devShells = eachSystem (system: let
      pkgs = pkgsFor.${system};
    in {
      # https://ryantm.github.io/nixpkgs/build-helpers/special/fhs-environments/
      default =
        (pkgs.buildFHSEnv {
          name = "temp";
          # packages for the main host arch
          targetPkgs = p: (with p; [
            gdb
            gcc
            xxd
            self.packages.${system}.pwndbg
            (python3.withPackages (py: [
              py.pwntools
            ]))
          ]);
          # packages to be installed for all arch supported by host
          # (e.g. i686 and x86_64 on x86_64 machine)
          multiPkgs = p: (with p; [
            glibc_multi
          ]);
          # install 32-bit multiPkgs also in 64-bit env
          multiArch = true;
          runScript = "zsh";
        }).env;
    });
  };
}
