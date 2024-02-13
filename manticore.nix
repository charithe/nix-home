{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    antora
    clickhouse
    cosign
    d2
    gcc
    istioctl
    jetbrains.idea-community
    jose
    natscli
    netlify-cli
    scc
    telepresence2
    temurin-bin-11
    tree-sitter
    trivy
  ];
}
