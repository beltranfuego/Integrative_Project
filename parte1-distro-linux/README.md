# Parte 1 — Distro Linux personalizada (Cubic)

**Nombre: Arthur Beltran · **Estado:** Completada

ISO personalizada basada en **Linux Mint Cinnamon**, con modificaciones persistentes
mediante repositorios APT, `/etc/skel`, overrides `gschema` y perfil `dconf`.

Documentación del proyecto: [README principal](../README.md) ·
[Evidencias](../docs/evidencias/lista-evidencias.md) ·
[Defensa oral](../docs/defensa-oral.md)

## Criterios de la rúbrica (checklist)

| Criterio | Cumplimiento | Evidencia |
|----------|--------------|-----------|
| ISO basada en Ubuntu/Mint | Linux Mint 22.x Cinnamon amd64 | ISO generada en `build/` |
| Boot correcto en VM | Verificado en VirtualBox/QEMU | `docs/evidencias/parte1/boot-vm.png` |
| ≥ 3 modificaciones justificadas | 6 modificaciones (tabla abajo) | Video + capturas |
| Persistencia skel/gschema | Scripts 02, 03 + usuario nuevo | `adduser testuser` |
| Video de demostración | 3–5 min (Cubic) + video integrador 8 min | [demo/enlaces.md](demo/enlaces.md) |

## Base elegida

| Campo | Valor |
|-------|-------|
| Distribución base | Linux Mint 22.x Cinnamon (amd64) |
| Justificación | Entorno familiar para el equipo, escritorio Cinnamon estable, compatible con Cubic y herramientas de desarrollo |
| Versión Cubic | 2024.x o superior (`sudo apt install cubic`) |

## Modificaciones implementadas

| # | Modificación | Mecanismo | Archivos en repo | Justificación |
|---|--------------|-----------|------------------|---------------|
| 1 | Firefox → LibreWolf | APT (`deb.librewolf.net`) + `update-alternatives` | `cubic/scripts/04-repos-and-packages.sh`, `05-browser-and-alternatives.sh` | Navegador orientado a privacidad, sin Firefox preinstalado |
| 2 | Neovim configurado | APT + `/etc/skel/.config/nvim/` | `skel/.config/nvim/init.lua`, `packages.list` | Editor listo para desarrollo desde el primer login |
| 3 | Visual Studio Code | APT (repo Microsoft) | `cubic/scripts/04-repos-and-packages.sh` | IDE estándar del equipo |
| 4 | Tema oscuro por defecto | `gschema` override + `dconf` en skel | `gschema/90_integrative-cinnamon.gschema.override`, `skel/.config/dconf/user` | Apariencia coherente en usuarios nuevos |
| 5 | Plantilla de usuario | `/etc/skel` | `skel/`, `cubic/scripts/02-skel-setup.sh` | Alias, bienvenida y configs por usuario |
| 6 | (Opcional) Branding | Scripts + `assets/` | `cubic/scripts/01-branding.sh`, `assets/` | Identidad visual del proyecto |

## Requisitos

- Cubic instalado en host con GUI (`sudo apt install cubic`)
- ISO **Linux Mint Cinnamon** amd64 descargada (no incluida en el repo)
- Conexión a Internet durante la personalización en Cubic (repos externos)
- ~10 GB de espacio libre para el build
- VM (VirtualBox/QEMU) para verificar el arranque

## Comandos en Cubic (terminal del chroot)

Ejecutar en la fase **Terminal / Customization** de Cubic, en este orden:

```bash
# 1. Copiar el repo al chroot (ajusta la ruta del host)
mkdir -p /root/custom
cp -a /ruta/en/tu/host/Integrative_Project/parte1-distro-linux/* /root/custom/

# 2. Ejecutar scripts en orden
export CUSTOM_ROOT=/root/custom
bash "${CUSTOM_ROOT}/cubic/scripts/04-repos-and-packages.sh"
bash "${CUSTOM_ROOT}/cubic/scripts/02-skel-setup.sh"
bash "${CUSTOM_ROOT}/cubic/scripts/03-gschema.sh"
bash "${CUSTOM_ROOT}/cubic/scripts/05-browser-and-alternatives.sh"
# Opcional: branding
# bash "${CUSTOM_ROOT}/cubic/scripts/01-branding.sh"

# 3. Comprobación rápida antes de generar la ISO
command -v librewolf code nvim
test -f /etc/skel/.config/nvim/init.lua
test -f /usr/share/glib-2.0/schemas/90_integrative-cinnamon.gschema.override
! dpkg -l firefox 2>/dev/null | grep -q '^ii'
```

Luego pulsa **Generate** en Cubic y guarda la ISO en `build/` (ignorada por Git).

Instrucciones detalladas: [build/INSTRUCCIONES-BUILD.md](build/INSTRUCCIONES-BUILD.md).

## Archivos que debes modificar

| Archivo | Qué cambia |
|---------|------------|
| `cubic/packages.list` | Paquetes APT adicionales (neovim, git, etc.) |
| `cubic/scripts/04-repos-and-packages.sh` | Repos de VS Code y LibreWolf; purga de Firefox |
| `cubic/scripts/02-skel-setup.sh` | Copia `skel/` → `/etc/skel` y fusiona `.bashrc` |
| `cubic/scripts/03-gschema.sh` | Instala y compila overrides de Cinnamon |
| `cubic/scripts/05-browser-and-alternatives.sh` | `x-www-browser` → LibreWolf |
| `gschema/90_integrative-cinnamon.gschema.override` | Tema GTK, iconos, cursor y navegador por defecto (sistema) |
| `skel/.config/nvim/init.lua` | Configuración de Neovim para usuarios nuevos |
| `skel/.config/dconf/user` | Preferencias Cinnamon por usuario al crearse la cuenta |
| `skel/.bashrc.d/10-integrative.sh` | Alias y mensaje de bienvenida |
| `skel/.bashrc.append` | Fragmento que se añade al `.bashrc` de plantilla Mint |

## Explicación de cada cambio

### 1. LibreWolf en lugar de Firefox

- Se añade el repositorio oficial `deb.librewolf.net` firmado con GPG.
- Se instala `librewolf` y se elimina `firefox` con `--purge`.
- `update-alternatives` registra LibreWolf como `x-www-browser`.
- **Por qué persiste:** los paquetes quedan en la imagen del sistema; las alternativas viven en `/etc/alternatives/`.

### 2. Neovim configurado

- `neovim` se instala por APT.
- `init.lua` en `/etc/skel/.config/nvim/` se copia a `~/.config/nvim/` al crear cada usuario (`useradd` copia `/etc/skel`).
- **Por qué persiste:** el binario está en la ISO; la config viaja en el home del usuario nuevo.

### 3. Visual Studio Code

- Repositorio Microsoft (`packages.microsoft.com/repos/code`), paquete `code`.
- **Por qué persiste:** instalación de sistema en `/usr/share/code`.

### 4. Tema por defecto (Mint-Y-Dark)

- **Capa sistema:** `90_integrative-cinnamon.gschema.override` fija valores por defecto de GTK, iconos, cursor y tema Cinnamon; `glib-compile-schemas` los activa.
- **Capa usuario:** `skel/.config/dconf/user` aplica las mismas claves en el primer login del usuario nuevo.
- **Por qué persiste:** overrides en `/usr/share/glib-2.0/schemas/`; dconf en el home generado desde skel.

### 5. `/etc/skel`

- Contiene dotfiles que Mint copia automáticamente al crear usuarios (`/etc/skel` → `/home/nuevo/`).
- `.bashrc.append` se fusiona sin borrar el `.bashrc` original de Mint.
- **Por qué persiste:** cada `adduser`/`useradd` replica skel; no afecta usuarios ya existentes en la sesión live.

## Verificación de persistencia

Probar en VM con la ISO generada:

### A. Sistema (afecta a todos los usuarios)

```bash
# Paquetes
dpkg -l | grep -E 'librewolf|code|neovim'
dpkg -l firefox   # no debe estar instalado (o estado rc tras purge)

# Navegador por defecto del sistema
update-alternatives --display x-www-browser | grep librewolf

# Overrides gschema compilados
grep -r Mint-Y-Dark /usr/share/glib-2.0/schemas/gschemas.compiled && echo OK
```

### B. Usuario nuevo (prueba crítica de skel + dconf)

```bash
# Crear usuario de prueba
sudo adduser --gecos "" testuser
sudo login testuser   # o cerrar sesión y entrar como testuser
```

Como `testuser`:

```bash
# Neovim
test -f ~/.config/nvim/init.lua && nvim --headless +'lua print(vim.o.number)' +qa

# Tema y navegador (Cinnamon)
gsettings get org.cinnamon.desktop.interface gtk-theme
# → 'Mint-Y-Dark'
gsettings get org.gnome.desktop.default-applications web-browser
# → ['librewolf.desktop']

# VS Code y LibreWolf
code --version
librewolf --version

# Bash personalizado
grep integrative ~/.bashrc
```


## Estructura de esta parte

```
parte1-distro-linux/
├── README.md
├── cubic/
│   ├── packages.list
│   └── scripts/
│       ├── 00-stage-repo.sh
│       ├── 02-skel-setup.sh
│       ├── 03-gschema.sh
│       ├── 04-repos-and-packages.sh
│       └── 05-browser-and-alternatives.sh
├── skel/
│   ├── .config/nvim/init.lua
│   ├── .config/dconf/user
│   └── .bashrc.d/
├── gschema/
│   └── 90_integrative-cinnamon.gschema.override
├── assets/
├── build/          # ISO generada (NO en Git)
└── demo/
```


1. `gschema/90_integrative-cinnamon.gschema.override`
2. `skel/.config/dconf/user`

Lista de temas instalados en el chroot: `ls /usr/share/themes`.
