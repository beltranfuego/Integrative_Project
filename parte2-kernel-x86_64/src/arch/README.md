# Episode 2 — Long mode y kernel en C

Código de bajo nivel para salir del arranque en 32 bits y ejecutar C en 64 bits.

| Archivo | Descripción |
|---------|-------------|
| `gdt.asm` | Descriptores de segmento y carga de GDT |
| `paging.asm` | Tablas de página (mapa identidad u otro esquema documentado) |

Ver también `../kernel/` para el código C una vez activo el modo largo.
