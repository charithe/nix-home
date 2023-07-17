{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cosign
    jetbrains.idea-community
    netlify-cli
    telepresence2
    temurin-bin-11
  ];
}
