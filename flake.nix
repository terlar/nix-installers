{
  description = "Build Nix bootstraping packages for legacy distributions";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nix.url = "github:NixOS/nix/2.16.0";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nix, nixpkgs, flake-utils }: (
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nixPackage = nix.packages.${system}.default;
        inherit (pkgs) lib;
      in
      {
        packages = import ./. { inherit pkgs lib nixPackage; };
        devShell = import ./shell.nix { inherit pkgs lib; };
      }
    )
  );

}
