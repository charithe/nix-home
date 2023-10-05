{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cosign
    jetbrains.idea-community
    jose
    netlify-cli
    telepresence2
    temurin-bin-11
    trivy
  ];
}
