set dotenv-load := true

default: update switch collect-garbage

update:
    @ nix flake update

switch:
    @ home-manager switch

collect-garbage:
    @ home-manager expire-generations "-12 hours"
    @ nix-collect-garbage

