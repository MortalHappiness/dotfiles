#!/usr/bin/env bash
#
# Check if the tools are installed and set up correctly

print_section() {
  echo "⚙️ $1"
}

check_tool() {
  local tool="$1"
  local error_message=""

  case "$tool" in
    fd)
      if ! command -v fd &>/dev/null && ! command -v fdfind &>/dev/null; then
        error_message="not installed"
      fi
      ;;
    bat)
      if ! command -v bat &>/dev/null && ! command -v batcat &>/dev/null; then
        error_message="not installed"
      fi
      ;;
    fish)
      if ! command -v fish &>/dev/null; then
        error_message="not installed"
      elif [[ "$SHELL" != *fish ]]; then
        error_message="installed, but not set as the current shell"
      fi
      ;;
    *)
      if ! command -v "$tool" &>/dev/null; then
        error_message="not installed"
      fi
      ;;
  esac

  if [[ -n "$error_message" ]]; then
    echo "  ❌ $tool: $error_message"
  else
    echo "  ✅ $tool"
  fi
}

print_section "Essential"
for tool in git vim tmux fish lazygit asdf direnv; do
  check_tool "$tool"
done

print_section "Programming"
for tool in python node; do
  check_tool "$tool"
done

print_section "Utilities"
for tool in fzf navi tldr; do
  check_tool "$tool"
done

print_section "Enhancements"
for tool in zoxide rg htop eza fd bat; do
  check_tool "$tool"
done

print_section "Docker"
for tool in docker lazydocker; do
  check_tool "$tool"
done

print_section "Kubernetes"
for tool in kubectl k9s helm minikube kind k3d; do
  check_tool "$tool"
done
