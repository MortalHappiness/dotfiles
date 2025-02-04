#!/usr/bin/env bash
#
# Check if the tools are installed and set up correctly

tools=(
  "git"
  "fish"
  "lazygit"
  "asdf"
  "navi"
  "direnv"
  "fzf"
  "zoxide"
  "rg"
  "htop"
  "eza"
  "fd"
  "bat"
)

for tool in "${tools[@]}"; do
  error_message=""

  if [[ "$tool" == "fd" ]]; then
    if ! command -v fd &>/dev/null && ! command -v fdfind &>/dev/null; then
      error_message="not installed"
    fi
  elif [[ "$tool" == "bat" ]]; then
    if ! command -v bat &>/dev/null && ! command -v batcat &>/dev/null; then
      error_message="not installed"
    fi
  elif [[ "$tool" == "fish" ]]; then
    if ! command -v fish &>/dev/null; then
      error_message="not installed"
    elif [[ "$SHELL" != *fish ]]; then
      error_message="installed, but not set as the current shell"
    fi
  elif ! command -v "$tool" &>/dev/null; then
    error_message="not installed"
  fi

  if [[ -n "$error_message" ]]; then
    echo "❌ $tool: $error_message"
  else
    echo "✅ $tool"
  fi
done
