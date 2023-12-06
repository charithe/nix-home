{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    antora
    cosign
    istioctl
    jetbrains.idea-community
    jose
    netlify-cli
    telepresence2
    temurin-bin-11
    trivy
  ];
}
