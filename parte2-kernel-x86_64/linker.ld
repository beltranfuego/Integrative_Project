/* linker.ld — Script de enlazado del kernel
 *
 * Episode 1: cargar en 1 MiB, secciones .multiboot, .text, .data, .bss
 * Episode 2: ajustar para long mode si hace falta
 *
 * Pendiente: definir secciones cuando exista el código ASM.
 */

ENTRY(_start)

SECTIONS
{
    . = 1M;

    /* TODO: .multiboot (header Multiboot2) */
    /* TODO: .text */
    /* TODO: .rodata */
    /* TODO: .data */
    /* TODO: .bss */
}
