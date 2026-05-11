{
  description = "My custom Nix packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = {
      veadotube-mini = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/veadotube-mini { };
      obs-pwvideo = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/obs-pwvideo { };
    };

    apps.x86_64-linux.veadotube-mini = {
      type = "app";
      program = "${self.packages.x86_64-linux.veadotube-mini}/bin/veadotube-mini";
    };
  };
}
