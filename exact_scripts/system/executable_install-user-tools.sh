#!/usr/bin/env bash

if [ ! -d "$HOME"/bin ]; then
  mkdir "$HOME"/bin
fi

# fisher
if ! fish -c "type -q fisher" &>/dev/null; then
    fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
    fish -c 'fisher update'
fi

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# navi
if ! command -v navi &>/dev/null; then
    BIN_DIR="$HOME"/bin bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
fi

# miniforge
if ! command -v conda &>/dev/null; then

curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b
cat <<EOF >> "$HOME"/.config/fish/config.local.fish
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" "hook" \$argv | source
else
    if test -f "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/miniforge3/bin" \$PATH
    end
end
# <<< conda initialize <<<
EOF

fi
