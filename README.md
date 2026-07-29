# Nix Flake For Pixi Package Manager

This Nix Flake uses a non-conventional Nix attribute path.

## Nix Attibute Path
- v0_75_0
  - machine_code
    - x86_64
      - linux
        - musl_libc
  - human_code
    - rust
  - shells
    - x86_64
      - linux
        - gnu_libc
          - gnu_bash
          - powershell
          - default

## To Use In A Nix Flake

```nix
{
  description = "Your Awesome Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/26.05";
    zm_pixi_repo.url = "github:zombiemaker/nix-zm_pixi";
  };

  outputs = {
    self,
    nixpkgs,
    zm_pixi_repo
  }:

  let
    nixpkgs_runtime_system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${nixpkgs_runtime_system};
    zm_pixi = zm_pixi_repo.v0_75_0; # Set the version of Pixi you want to use ("latest" is the most current version)

  in {
    latest = {
      shells = {
        x86_64 = {
          linux = {
            gnu_libc = {
              powershell_nixi = pkgs.mkShell {
                name = "powershell_pixi";

                buildInputs = [
                  pkgs.bashInteractive
                ];

                packages = [
                  pkgs.powershell
                  zm_pixi.machine_code.x86_64.linux.musl_libc
                ];
              };

              default = self.devShells.x86_64-linux.pixi_vortex_python_api;
            };

            musl_libc = {
              powershell_pixi = pkgs.mkShell {
                name = "powershell_pixi";

                buildInputs = [
                  pkgs.bashInteractive
                ];

                packages = [
                  pkgs.powershell
                  zm_pixi.machine_code.x86_64.linux.musl_libc
                ];
              };
            };
          };
        };
      };
    };
  };
}

```
