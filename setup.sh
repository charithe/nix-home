#!/usr/bin/env bash

set -euo pipefail

HM_DIR="${HOME}/.config/home-manager"
MACHINE="$(hostname)"

mkdir -p "$HM_DIR"
ln -s "${PWD}/${MACHINE}.nix" "${HM_DIR}/home.nix"

