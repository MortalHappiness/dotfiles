#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR"/install-helper.sh

# Shared user tools
bash "$DIR"/install-shared-user-tools.sh

# gh
if ! command -v gh &>/dev/null; then
  VERSION=$(parse_latest_release "cli/cli")
  curl -Lo gh.tar.gz "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz"
  tar xf gh.tar.gz
  mv gh_${VERSION}_linux_amd64/bin/gh "$HOME"/bin/
  rm -rf gh_${VERSION}_linux_amd64 gh.tar.gz
fi

# diff-so-fancy
if ! command -v diff-so-fancy &>/dev/null; then
  VERSION=$(parse_latest_release "so-fancy/diff-so-fancy")
  curl -Lo diff-so-fancy "https://github.com/so-fancy/diff-so-fancy/releases/download/v${VERSION}/diff-so-fancy"
  chmod +x diff-so-fancy
  mv diff-so-fancy "$HOME"/bin/
fi

# bat
if ! command -v bat &>/dev/null; then
  VERSION=$(parse_latest_release "sharkdp/bat")
  # https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-unknown-linux-gnu.tar.gz
  curl -Lo bat.tar.gz "https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz"
  tar xf bat.tar.gz
  mv bat-v${VERSION}-x86_64-unknown-linux-gnu/bat "$HOME"/bin/
  rm -rf bat-v${VERSION}-x86_64-unknown-linux-gnu bat.tar.gz
fi