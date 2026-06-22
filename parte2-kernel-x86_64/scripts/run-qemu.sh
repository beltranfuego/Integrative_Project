#!/usr/bin/env bash
# scripts/run-qemu.sh — Lanza QEMU con la ISO del kernel
#
# Uso: run-qemu.sh [ruta-a-kernel.iso]

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ISO="${1:-${ROOT}/output/kernel.iso}"
QEMU_ARGS_FILE="${ROOT}/config/qemu.args"

if [[ ! -f "${ISO}" ]]; then
    echo "No se encontró ${ISO}. Ejecuta 'make build' primero." >&2
    exit 1
fi

QEMU_OPTS=(-cdrom "${ISO}")

if [[ -f "${QEMU_ARGS_FILE}" ]]; then
    # shellcheck disable=SC2207
    EXTRA=($(grep -v '^\s*#' "${QEMU_ARGS_FILE}" | tr '\n' ' '))
    QEMU_OPTS+=("${EXTRA[@]}")
else
    QEMU_OPTS+=(-serial stdio -display gtk)
fi

exec qemu-system-x86_64 "${QEMU_OPTS[@]}"
