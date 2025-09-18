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
