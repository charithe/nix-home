{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    antora
    clickhouse
    corepack_latest
    cosign
    crane
    dbeaver-bin
    dive
    flyctl
    gcc
    ghz
    glasskube
    istioctl
        #jetbrains.idea-community
    jose
    natscli
    netlify-cli
    nodejs
    pgformatter
    redocly
    scc
    syft
    telepresence2
    temurin-bin-11
    tree-sitter
    trivy
  ];
}
