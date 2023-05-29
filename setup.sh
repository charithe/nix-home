#!/usr/bin/env bash

set -euo pipefail

HM_DIR="${HOME}/.config/home-manager"
MACHINE="$(hostname)"

mkdir -p "$HM_DIR"
for FILE in config data common.nix flake.lock flake.nix; do
    ln -s "${PWD}/${FILE}" "${HM_DIR}/${FILE}"
done

ln -s "${PWD}/${MACHINE}.nix" "${HM_DIR}/home.nix"

