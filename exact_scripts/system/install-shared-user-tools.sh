# Install shared tools for both laptop and workstation

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR"/install-helper.sh

if [ ! -d "$HOME"/bin ]; then
  mkdir "$HOME"/bin
fi

# zoxide
if ! command -v zoxide &>/dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# navi
if ! command -v navi &>/dev/null; then
  BIN_DIR="$HOME"/bin bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
fi

# lazygit
if ! command -v lazygit &>/dev/null; then
  VERSION=$(parse_latest_release "jesseduffield/lazygit")
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/lazygit_${VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  mv lazygit "$HOME"/bin/
  rm lazygit.tar.gz
fi

# asdf
if ! command -v asdf &>/dev/null; then
  VERSION=$(parse_latest_release "asdf-vm/asdf")
  curl -Lo asdf.tar.gz "https://github.com/asdf-vm/asdf/releases/download/v${VERSION}/asdf-v${VERSION}-linux-amd64.tar.gz"
  tar xf asdf.tar.gz asdf
  mv asdf "$HOME"/bin/
  rm asdf.tar.gz
fi