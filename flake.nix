{
  description = "Xnode OS";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    nixos-generators.url = "github:nix-community/nixos-generators";
    #xnode-pkgs.url = "github:Openmesh-Network/XnodeOS"; # Circular input to top level flake
  };
  outputs = inputs:
    let
      flakeContext = {
        inherit inputs;
        openmesh-core = inputs: (inputs.nixpkgs.callPackage ./packages/openmesh-core) { };

      };
    in
    {
      packages = {
        x86_64-linux = {
          iso = import ./packages/iso.nix flakeContext;
        };
      };
    };
}
