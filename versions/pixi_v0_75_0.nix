{
    pkgs
}:

let
    v0_75_0_mc_x86_64_linux_musl_libc = pkgs.stdenv.mkDerivation {
        name = "zm_pixi-machine_code.x86_64.linux.musl_libc";
        version = "0.75.0";
        archive_file = pkgs.fetchurl {
            url = "https://github.com/prefix-dev/pixi/releases/download/v0.75.0/pixi-x86_64-unknown-linux-musl";
            sha256 = "sha256-Q4Ou0YstVWnPNKGWONr5VKpEFcyHrTqdqfNAWcxKAEw=";
        };

        nativeBuildInputs = [];

        phases = [
            "installPhase"
        ];

        installPhase = ''
            mkdir -p $out/bin
            cp $archive_file $out/bin/pixi
            chmod +x $out/bin/pixi
        '';
    };

    v0_75_0_hc_rust = pkgs.stdenv.mkDerivation {
        name = "zm_pixi-human_code.rust";
        version = "0.75.0";
        src = pkgs.fetchurl {
            name = "archive.tar.gz";
            url = "https://github.com/prefix-dev/pixi/archive/refs/tags/v0.75.0.tar.gz";
            sha256 = "sha256-yyYeKF1XwmWEpyT7iDfTTzNDADAG8W5zlJETon9jLeE=";
        };

        nativeBuildInputs = [];

        phases = [
            "unpackPhase"
            "installPhase"
        ];

        installPhase = ''
            mkdir -p $out
            tar xvf $src --directory $out --strip-components=1r
        '';
    };

    v0_75_0_shell_x86_64_linux_gnu_libc_gnu_bash = pkgs.mkShell {
        name = "zm_pixi-shell-v0_75_0-gnu_bash";
        buildInputs = [
            pkgs.bashInteractive
        ];

        packages = [
            v0_75_0_mc_x86_64_linux_musl_libc
        ];

        shellHook = ''
        '';
    };

    v0_75_0_shell_x86_64_linux_gnu_libc_powershell = pkgs.mkShell {
        name = "zm_pixi-shell-v0_75_0-powershell";
        buildInputs = [
            pkgs.bashInteractive
        ];

        packages = [
            pkgs.powershell
            v0_75_0_mc_x86_64_linux_musl_libc
        ];

        shellHook = ''
            exec pwsh -NoLogo -NoExit
        '';
    };


    result = rec {
        machine_code = {
            x86_64 = {
                linux = {
                    musl_libc = v0_75_0_mc_x86_64_linux_musl_libc;
                };
            };
        };

        human_code = {
            rust = v0_75_0_hc_rust;
        };

        shells = {
            x86_64 = {
                linux = {
                    gnu_libc = {
                        gnu_bash = v0_75_0_shell_x86_64_linux_gnu_libc_gnu_bash;
                        powershell = v0_75_0_shell_x86_64_linux_gnu_libc_powershell;
                        default = result.shells.x86_64.linux.gnu_libc.gnu_bash;
                    };
                };
            };
        };
    };

in
    result
