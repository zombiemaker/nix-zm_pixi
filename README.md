# Nix Flake For Pixi Package Manager

This Nix Flake uses a non-conventional Nix attribute path.

## Nix Attibute Path
- v0_75_0
  - machine_code
    - x86_64
      - linux
        - gnu_libc
        - musl_libc
  - human_code
    - rust
  - shells
    - x86_64
      - linux
        - gnu_libc
          - gnu_bash
          - powershell
          - default                         :
