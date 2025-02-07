set dotenv-load := true

default: format update switch collect-garbage

format:
    @ alejandra *.nix

update:
    @ nix flake update

switch:
    @ home-manager switch

collect-garbage:
    @ home-manager expire-generations "-12 hours"
    @ nix-collect-garbage

upgrade:
    @ topgrade --only custom_commands flatpak gnome_shell_extensions helm home_manager krew nix rustup system

