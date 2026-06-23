# Lista de evidencias — Proyecto integrador

Inventario completo de evidencias alineado con la [rúbrica](../rubrica.md).
Convención de nombres: `YYYY-MM-DD_parteN_descripcion.ext`

---

## Resumen por parte

| Parte | Puntos | Evidencias obligatorias | Carpeta |
|-------|--------|-------------------------|---------|
| 1 — Cubic | 25 | ISO checksum, boot, skel, video | `docs/evidencias/parte1/` |
| 2 — Kernel | 30 | Build, Episode 1 OK, Episode 2 banner | `docs/evidencias/parte2/` |
| 3 — BHB | 35 | make test, redes, playbook ofensivo | `docs/evidencias/parte3/` |
| Repo | 10 | READMEs, commits, verify-all | Raíz + `docs/` |

---

## Parte 1 — Distro Linux (Cubic)

### Obligatorias

| # | Evidencia | Archivo sugerido | Cómo generarla | Criterio rúbrica |
|---|-----------|-----------------|----------------|------------------|
| 1 | Checksum SHA256 de la ISO | `parte1/SHA256SUMS` | `sha256sum build/*.iso` | ISO personalizada |
| 2 | Captura de arranque exitoso | `parte1/boot-vm.png` | Screenshot VM al login | Boot correcto |
| 3 | LibreWolf como navegador | `parte1/librewolf-menu.png` | Menú aplicaciones / `librewolf --version` | Modificación 1 |
| 4 | Neovim con config | `parte1/nvim-init.png` | `nvim` en usuario nuevo | Modificación 2 |
| 5 | VS Code instalado | `parte1/code-version.png` | `code --version` | Modificación 3 |
| 6 | Tema oscuro Mint-Y-Dark | `parte1/tema-oscuro.png` | Escritorio Cinnamon | Modificación 4 |
| 7 | Usuario nuevo hereda skel | `parte1/usuario-testuser.png` | `adduser testuser` + login | Persistencia skel |
| 8 | gschema override activo | `parte1/gsettings-tema.txt` | `gsettings get org.cinnamon.desktop.interface gtk-theme` | Persistencia gschema |
| 9 | Video demostración | Enlace externo | Ver `parte1-distro-linux/demo/enlaces.md` | Video |

### Opcionales (refuerzo)

| Evidencia | Archivo | Notas |
|-----------|---------|-------|
| Firefox ausente | `parte1/sin-firefox.png` | `dpkg -l firefox` |
| Salida scripts Cubic | `parte1/chroot-scripts.log` | Terminal durante build |
| Branding / wallpaper | `parte1/branding.png` | Si se aplicó `01-branding.sh` |

---

## Parte 2 — Kernel x86_64

### Obligatorias

| # | Evidencia | Archivo sugerido | Cómo generarla | Criterio rúbrica |
|---|-----------|-----------------|----------------|------------------|
| 1 | Build Episode 2 exitoso | `parte2/build-episode2-terminal.png` | `make docker-episode2` o `make episode2` | Build reproducible |
| 2 | kernel.iso generado | `parte2/ls-output-kernel.iso.txt` | `ls -lh output/kernel.iso` | kernel.iso |
| 3 | Episode 1 — OK en VGA | `parte2/qemu-episode1-ok.png` | `make episode1 && make run` | Episode 1 OK |
| 4 | Episode 2 — banner grupo | `parte2/qemu-episode2-banner.png` | `make episode2 && make run` | Episode 2 completo |
| 5 | Docker build toolchain | `parte2/docker-build-ok.png` | `make docker-build` | Docker |
| 6 | readelf Multiboot2 | `parte2/readelf-kernel-ep2.png` | `readelf -h build/kernel-ep2.elf` | Multiboot2 / ELF64 |

### Opcionales (demuestran profundidad)

| Evidencia | Archivo | Notas |
|-----------|---------|-------|
| ERR: 0 multiboot | `parte2/qemu-err-multiboot.png` | Test check fallido |
| ERR: 1 CPUID | `parte2/qemu-err-cpuid.png` | Test check fallido |
| ERR: 2 long mode | `parte2/qemu-err-longmode.png` | Test check fallido |
| Log QEMU serial | `parte2/qemu-serial.log` | Salida `-serial stdio` |

Lista ampliada: [parte2/README.md](parte2/README.md), [EPISODE2.md](../../parte2-kernel-x86_64/EPISODE2.md).

---

## Parte 3 — Black Hat Bash

### Obligatorias

| # | Evidencia | Archivo sugerido | Cómo generarla | Criterio rúbrica |
|---|-----------|-----------------|----------------|------------------|
| 1 | `make deploy` — 8 UP | `parte3/docker-ps.png` | `docker compose ps` | 8 contenedores |
| 2 | `make test` completo | `parte3/make-test-output.log` | `make test 2>&1 \| tee …` | make test |
| 3 | Verificación de redes | `parte3/verify-network.log` | `network/verify-network.sh` | Verificación redes |
| 4 | RustScan subred | `parte3/01-rustscan-subred.txt` | `exploit.sh` | Técnica ofensiva |
| 5 | Nmap servicios | `parte3/03-nmap-servicios.*` | `exploit.sh` | Reconocimiento |
| 6 | FTP anónimo | `parte3/04-nmap-ftp-anon.txt` | Nmap NSE | Explotación controlada |
| 7 | Dirsearch rutas | `parte3/09-dirsearch-web01.txt` | `/upload` descubierto | Enumeración |
| 8 | .git expuesto | `parte3/10-dirsearch-git-impact.txt` | `/.git/config` | Hallazgo crítico |
| 9 | Listado FTP backup | `parte3/17-ftp-anon-listado.txt` | lftp anonymous | Acceso no autorizado |
| 10 | WP user enum | `parte3/18-wp-user-enum.json` | REST API | Enumeración |

### Opcionales

| Evidencia | Archivo | Notas |
|-----------|---------|-------|
| victim-web en navegador | `parte3/browser-victim-web.png` | `http://localhost:8080` |
| Directory indexing backup | `parte3/browser-backup.png` | Desde attacker |
| SHA256 evidencias | `parte3/SHA256SUMS` | Integridad de logs |

### Generación automática

```bash
cd parte3-black-hat-bash
make deploy
make test
cp -r offensive/evidencia/* ../docs/evidencias/parte3/
```

---

## Documentación y repositorio (10 pts)

| # | Evidencia | Ubicación | Criterio |
|---|-----------|-----------|----------|
| 1 | README principal | `/README.md` | README principal |
| 2 | README Cubic | `parte1-distro-linux/README.md` | README por parte |
| 3 | README Kernel | `parte2-kernel-x86_64/README.md` | README por parte |
| 4 | README BHB | `parte3-black-hat-bash/README.md` | README por parte |
| 5 | Arquitectura | `docs/arquitectura-laboratorio.md` | Documentación |
| 6 | Diagrama redes | `docs/diagrama-redes.md` | Documentación |
| 7 | Guion video 8 min | `docs/guion-video-final.md` | Demostración |
| 8 | Defensa oral | `docs/defensa-oral.md` | Preparación entrega |
| 9 | verify-all OK | `parte3/verify-all.log` | Reproducibilidad |
| 10 | Historial git | `git log --oneline` | Commits distribuidos |

