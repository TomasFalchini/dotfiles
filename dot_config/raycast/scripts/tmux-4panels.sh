#!/bin/bash
set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tmux 4 Panels
# @raycast.mode compact
# @raycast.argument1 { "type": "text", "placeholder": "session-name", "percentEncoded": false }


# Optional parameters:
# @raycast.icon terminal
# @raycast.packageName tmux

# Script para crear una sesión de tmux con 4 paneles
# Uso: tmux-4panels.sh [session-name]

if ! command -v tmux >/dev/null 2>&1; then
  echo "tmux is not installed."
  exit 1
fi

SESSION_NAME="${1:-dev}"

escape_applescript_string() {
  local s="${1-}"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  printf '%s' "$s"
}

open_iterm_and_attach() {
  local app=""
  if open -Ra "iTerm" >/dev/null 2>&1; then
    app="iTerm"
  elif open -Ra "iTerm2" >/dev/null 2>&1; then
    app="iTerm2"
  else
    echo "iTerm is not installed."
    exit 1
  fi

  local attach_cmd
  attach_cmd="$(printf 'tmux attach-session -t %q' "$SESSION_NAME")"

  # Requires Raycast to have Automation permission to control iTerm.
  osascript -e "tell application \"${app}\"" \
            -e "activate" \
            -e "if (count of windows) = 0 then" \
            -e "  create window with default profile" \
            -e "end if" \
            -e "tell current session of current window to write text \"$(escape_applescript_string "$attach_cmd")\"" \
            -e "end tell" >/dev/null
}

attach() {
  # If we're running in an interactive terminal, attach here.
  if [[ -t 0 && -t 1 ]]; then
    tmux attach-session -t "$SESSION_NAME"
  else
    open_iterm_and_attach
  fi
}

# Verificar si la sesión ya existe
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session '$SESSION_NAME' already exists. Attaching..."
  attach
  exit 0
fi

# Crear nueva sesión con el primer panel
tmux new-session -d -s "$SESSION_NAME"

# Dividir horizontalmente (crea 2 paneles)
tmux split-window -h -t "$SESSION_NAME"

# Dividir el panel izquierdo verticalmente (crea 3 paneles)
tmux split-window -v -t "$SESSION_NAME:1.1"

# Dividir el panel derecho verticalmente (crea 4 paneles)
tmux split-window -v -t "$SESSION_NAME:1.3"

# Ajustar tamaños para distribución uniforme
tmux select-layout -t "$SESSION_NAME" tiled

# Seleccionar el primer panel
tmux select-pane -t "$SESSION_NAME:1.1"

attach
