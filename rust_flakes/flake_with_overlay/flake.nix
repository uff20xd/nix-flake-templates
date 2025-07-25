{
  description = "A devShell example";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            openssl
            pkg-config
            eza
            fd
            rust-bin.beta.latest.default
            #rust-bin.selectLatestNightlyWith ( toolchain: toolchain.default.override {
            #  extension = [];
            #  targets = [ "x86_64-unknown-none" ];
            #})
          ];

          shellHook = ''
            alias ls=eza
            alias find=fd
          '';
        };
      }
    );
}
