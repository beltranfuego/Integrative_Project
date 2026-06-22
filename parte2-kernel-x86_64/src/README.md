# Código fuente — Parte 2 Kernel x86_64

Organización por episodios del tutorial *Write Your Own 64-bit Operating System*.

## Episode 1 (objetivo actual)

| Archivo | Rol |
|---------|-----|
| `boot/header.asm` | Cabecera Multiboot2 (GRUB carga el kernel) |
| `boot/boot.asm` | `_start`: escribir `OK` en `0xB8000` |

Salida: `output/kernel.bin` → `output/kernel.iso` → QEMU.

## Episode 2 (futuro)

| Carpeta / archivo | Rol |
|-------------------|-----|
| `arch/gdt.asm` | GDT para modo 64 bits |
| `arch/paging.asm` | Paginación |
| `kernel/main.c` | Lógica principal en C |
| `kernel/vga.c` | Consola VGA (opcional) |

## Convenciones

- **Episode 1** ensambla con `nasm -f elf32` y enlaza con `ld -m elf_i386`.
- **Episode 2** añadirá `-f elf64` y objetos C compilados con `gcc -ffreestanding`.
- Los artefactos **nunca** se versionan: van a `build/`, `iso/` y `output/`.
