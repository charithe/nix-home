{
  config,
  pkgs,
  ...
}: let
  oldpkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bce5fe2bb998488d8e7e7856315f90496723793c.tar.gz";
    sha256 = "0hkpgac4djwffciz171h37zb8xx26q6af1aa0c87233kgvscn1dz";
  }) {system = "x86_64-linux";};

  cosign261 = oldpkgs.cosign;
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.packages = with pkgs; [
    antora
    binaryen
    claude-code
    cosign
    crane
    dive
    envoy-bin
    gcc
    ghz
    grype
    istioctl
    jetbrains.idea-oss
    jose
    natscli
    #netlify-cli
    osv-scanner
    pnpm
    redocly
    scc
    spire
    syft
    telepresence2
    temurin-bin-21
    tinygo
    tree-sitter
    trivy
    valkey
    wasmedge
    wasm-tools
    wkg
  ];
}
