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
        error_message='installed, but not set as the current shell. Run "chsh -s $(which fish)" to change the shell.'
      fi
      ;;
    git)
      if ! command -v git &>/dev/null; then
        error_message="not installed"
      else
        required_version="2.34.0"
        git_version=$(git --version | awk '{print $3}')
        if [[ "$(printf "%s\n%s" "$required_version" "$git_version" | sort -V | head -n1)" == "$git_version" ]]; then
          error_message="installed, but version ($git_version) is not greater than $required_version"
        fi
      fi
      ;;
    vim)
      if ! command -v vim &>/dev/null; then
        error_message="not installed"
      else
        required_major_version=9
        vim_version=$(vim --version | awk 'NR==1 {print $5}' | cut -d. -f1)
        if [[ "$vim_version" -lt "$required_major_version" ]]; then
          error_message="installed, but version ($vim_version) is less than $required_major_version"
        fi
      fi
      ;;
    fisher)
      if ! command -v fish &>/dev/null; then
        error_message="fish not installed"
      elif ! fish -c "type -q fisher" &>/dev/null; then
        error_message="not installed"
      elif [[ $(fish -c "fisher list | wc -l") -eq 1 ]]; then
        error_message='installed, but plugins are not installed. Run "fisher update" to install plugins.'
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
for tool in chezmoi git vim tmux fish fisher lazygit diff-so-fancy asdf direnv; do
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
