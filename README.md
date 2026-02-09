# Dotfiles

Configuración de entorno de desarrollo para macOS, gestionada con [chezmoi](https://www.chezmoi.io/).

## Requisitos

- macOS (Apple Silicon o Intel)
- Conexión a internet

## Instalación rápida

```bash
curl -sfL https://raw.githubusercontent.com/tomasfalchini/dotfiles/master/.init_setup.sh | bash
```

El script instala automáticamente:

- Xcode Command Line Tools
- Homebrew
- Oh My Zsh
- Chezmoi
- Cursor
- Y aplica todos los dotfiles

## Instalación manual

```bash
# 1. Instalar chezmoi
brew install chezmoi

# 2. Inicializar y aplicar
chezmoi init https://github.com/tomasfalchini/dotfiles.git
chezmoi apply
```

En el primer `apply`, chezmoi te pedirá algunos datos (email, usuario de GitHub, etc.) para personalizar la configuración.

## Estructura del repositorio

```
dot_config/          → ~/.config/  (XDG)
├── docker/          # Docker (Colima)
├── gh/              # GitHub CLI
├── raycast/scripts/ # Scripts para Raycast
└── starship/        # Prompt Starship

dot_dotfiles/        → ~/.dotfiles/
├── dot_aliases      # Aliases de shell
├── dot_exports      # Variables de entorno
└── dot_functions    # Funciones de shell

dot_cursor/          → ~/.cursor/
└── private_mcp.json # MCP servers de Cursor

dot_cargo/           → ~/.cargo/
dot_colima/          → ~/.colima/
dot_tmux.conf        → ~/.tmux.conf
dot_zshrc            → ~/.zshrc
private_dot_ssh/     → ~/.ssh/
```

## Qué incluye

### Shell (zsh + Oh My Zsh)

- Plugins: git, aws, docker, kubectl, terraform, autosuggestions, syntax-highlighting
- Aliases para kubectl, git, gh, jira, terraform, aws
- Funciones: `mcd`, `extract`, `preview`, `zi`, `jira-open`, `task`
- Herramientas: fzf, zoxide, direnv, atuin
- Prompt: Starship

### Herramientas (brew)

- Desarrolladores: bat, eza, fd, ripgrep, lazygit, git-delta
- Kubernetes: kubectl, helm, k9s, stern
- Infra: terraform, tflint, docker, colima
- Utilidades: fzf, zoxide, atuin, jq, yq
- Apps: Cursor, Raycast, Slack, Chrome

### Tmux

- Tema Dracula
- Atajos tipo vim (Alt + flechas para paneles)
- Plugins: TPM, powerline

### Raycast

Scripts para crear sesiones de tmux con 3 o 4 paneles, invocables desde Raycast.

## Post-instalación

### 1. Raycast

Para que los scripts de tmux aparezcan en Raycast:

1. Abrir Raycast Preferences (⌘ + ,)
2. Ir a **Extensions → Scripts → Script Commands**
3. Click en **Add Directories**
4. Seleccionar `~/.config/raycast/scripts/`

### 2. Tmux plugins (TPM)

La primera vez que abras tmux, instala los plugins con:

```
prefix + I   (Ctrl+b, luego I)
```

## Comandos útiles

```bash
# Ver cambios que se aplicarían
chezmoi diff

# Aplicar dotfiles
chezmoi apply

# Editar un archivo gestionado
chezmoi edit ~/.zshrc

# Actualizar desde el repo
chezmoi update
```

## Variables de entorno

| Variable | Uso |
|----------|-----|
| `XDG_CONFIG_HOME` | Base para configs (~/.config) |
| `DOCKER_CONFIG` | Config de Docker |
| `STARSHIP_CONFIG` | Config de Starship |
| `EDITOR` | `cursor --wait` |

## Licencia

Uso personal.
