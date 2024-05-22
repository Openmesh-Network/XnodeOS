{
  description = "Xnode OS";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    nixos-generators.url = "github:nix-community/nixos-generators";
    xnodeos-pkgs.url = "github:Openmesh-Network/XnodeOS"; # Private repo, 404 error
  };
  outputs = inputs:
    let
      flakeContext = {
        inherit inputs;
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
