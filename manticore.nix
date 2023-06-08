{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cosign
    jetbrains.idea-community
    telepresence2
    temurin-bin-11
  ];
}
