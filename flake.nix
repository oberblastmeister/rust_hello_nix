{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {
        inherit system;
        overlays = [
          /* rust-overlay.overlay */
          /* (final: prev: { */
          /*   rustc = final.rust-bin.stable.latest.default; */
          /*   cargo = final.rust-bin.stable.latest.default; */
          /* }) */
        ];
      }; in
      rec {
        packages.hello = pkgs.callPackage ./hello.nix { version = "1.0.0"; };
        defaultPackage = packages.hello;
        apps.hello = flake-utils.lib.mkApp { drv = packages.hello; };
        defaultApp = apps.hello;
      }
    );
}
