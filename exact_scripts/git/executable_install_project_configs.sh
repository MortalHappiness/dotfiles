#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$HOME/Projects/project-configs"

if ! command -v stow >/dev/null 2>&1; then
  echo "Error: Command 'stow' not found. Skip installation." >&2
  exit 1
fi

if [[ ! -d "$CONFIG_DIR" ]]; then
  echo "Error: ~/Projects/project-configs/ not found. Skip installation." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: Must be run inside a git repository." >&2
  exit 1
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
REAL_REPO_ROOT="$(realpath "$REPO_ROOT")"
REPO_NAME="$(basename "$REAL_REPO_ROOT")"
PROJECT_CONFIG="$CONFIG_DIR/$REPO_NAME"

if [[ ! -d "$PROJECT_CONFIG" ]]; then
  echo "Error: Project config '$REPO_NAME' not found in ~/Projects/project-configs/." >&2
  exit 1
fi

stow --dotfiles -d "$CONFIG_DIR" -t "$REAL_REPO_ROOT" "$REPO_NAME" -v 1
