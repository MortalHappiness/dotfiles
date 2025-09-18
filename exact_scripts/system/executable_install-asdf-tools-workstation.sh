#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR"/install-helper.sh

plugins=(
  "fzf"
  "ripgrep"
  "direnv"
  "eza"
  "fd"
  "duf"
  "dust"
)

install_asdf_plugins "${plugins[@]}"
