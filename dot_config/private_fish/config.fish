set -xg EDITOR vim
umask 022
set fish_greeting

set -g fish_key_bindings fish_hybrid_key_bindings

# ========================================
# PATH

if not contains "$HOME/bin" $PATH
  set -gx --append PATH "$HOME/bin"
end

if not contains "$HOME/.local/bin" $PATH
  set -gx --append PATH "$HOME/.local/bin"
end

# ========================================
# Aliases

if type -q bat
  alias cat="bat"
else if type -q batcat
  alias bat="batcat"
  alias cat="batcat"
end

if type -q fdfind
  alias fd="fdfind"
end

if type -q dust
  alias du="dust"
end

if type -q duf
  alias df="duf"
end

if type -q eza
  alias ls="eza -F"
  alias ll="eza -F --long --header --group"
  alias la="eza -F --long --header --group --all"
end

if type -q rg
  alias grep="rg"
end

if type -q lazygit
  alias lg="lazygit"
end

if type -q chezmoi
  alias dotfile="chezmoi"
end

# ========================================
# External tools

# fzf
set -x FZF_DEFAULT_OPTS '
  --layout=reverse
  --color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672
'

# fzf.fish
if functions -q fzf_configure_bindings
  fzf_configure_bindings --directory=\cf --git_log= --git_status= --processes= --variables=\e\cv
end

# zoxide
if type -q zoxide
  zoxide init fish --cmd cd | source
end

# thefuck
if type -q thefuck
  thefuck --alias | source
end

# navi
if type -q navi
  navi widget fish | source
end

# direnv
if type -q direnv
  direnv hook fish | source
end

# ========================================
# asdf
if test -z $ASDF_DATA_DIR
  set _asdf_shims "$HOME/.asdf/shims"
else
  set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

set -x ASDF_NODEJS_AUTO_ENABLE_COREPACK 1

# ========================================
# Personal tools

if functions -q __auto_source_venv
  __auto_source_venv
end

# ========================================
# Include local config

set -l local_config_file "$__fish_config_dir/config.local.fish"
if test -f $local_config_file
  source $local_config_file
end
