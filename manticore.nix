{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cosign
    jetbrains.idea-community
    temurin-bin-11
  ];
}
