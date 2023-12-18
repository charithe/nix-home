{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    antora
    cosign
    gcc
    istioctl
    jetbrains.idea-community
    jose
    netlify-cli
    scc
    telepresence2
    temurin-bin-11
    trivy
  ];
}
