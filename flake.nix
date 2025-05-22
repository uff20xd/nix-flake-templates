{
  description = "minimal nixos iso";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      minimal = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({pkgs, modulesPath, ...}: {imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"]; })
          ./iso-config.nix
        ];
      };
    };
  };
}
