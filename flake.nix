{
  description = "Home Manager configuration of cell";

  nixConfig = {
    extra-substituters = ["https://ghostty.cachix.org"];
    extra-trusted-public-keys = ["ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = {
    nixpkgs,
    home-manager,
    zig,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."cell@mitochondria" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./common.nix ./mitochondria.nix {nixpkgs.overlays = [zig.overlays.default];}];
    };
    homeConfigurations."cell@manticore" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./common.nix ./manticore.nix {nixpkgs.overlays = [zig.overlays.default];}];
    };
  };
}
