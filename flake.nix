{
    description = "ZombieMaker derivation for Pixi";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/26.05";
    };

    outputs = {
        self,
        nixpkgs
    }:

    let
        nixpkgs_runtime_system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${nixpkgs_runtime_system};
    
        pixi_v0_75_0 = pkgs.callPackage ./versions/pixi_v0_75_0.nix;

    in {
        v0_75_0 = pixi_v0_75_0 {pkgs = pkgs;};

        latest = self.outputs.v0_75_0;
    };
}

