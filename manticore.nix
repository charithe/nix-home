{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    antora
    cosign
    d2
    gcc
    istioctl
    jetbrains.idea-community
    jose
    netlify-cli
    scc
    telepresence2
    temurin-bin-11
    tree-sitter
    trivy
  ];
}
