#!/usr/bin/env bash
# scripts/build-iso.sh — Empaqueta kernel.bin en una ISO booteable con GRUB (Multiboot2)
#
# Uso: build-iso.sh <kernel.bin> <grub.cfg> <salida.iso> <staging-dir>

set -euo pipefail

KERNEL_BIN="${1:?kernel.bin requerido}"
GRUB_CFG="${2:?grub.cfg requerido}"
OUTPUT_ISO="${3:?kernel.iso requerido}"
STAGING="${4:?directorio staging requerido}"

BOOT_DIR="${STAGING}/boot/grub"

rm -rf "${STAGING}"
mkdir -p "${BOOT_DIR}"

cp "${KERNEL_BIN}" "${STAGING}/boot/kernel.bin"
cp "${GRUB_CFG}" "${BOOT_DIR}/grub.cfg"

grub-mkrescue -o "${OUTPUT_ISO}" "${STAGING}" 2>/dev/null

echo "ISO generada: ${OUTPUT_ISO}"
