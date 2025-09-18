# Helper functions

parse_latest_release() {
  curl -s "https://api.github.com/repos/$1/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*'
}

# Install one or more asdf plugins and set versions. Accepts arbitrary plugin names as args
install_asdf_plugins() {
  if [ "$#" -eq 0 ]; then
    echo "install_asdf_plugins: no plugins specified"
    return 1
  fi

  for plugin in "$@"; do
    case $plugin in
      "lazydocker")
        asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
        asdf install lazydocker latest
        asdf set --home lazydocker latest
        ;;
      "nodejs")
        asdf plugin add nodejs
        asdf nodejs update-nodebuild
        version=$(asdf nodejs resolve lts)
        if [ -z "$version" ]; then
          echo "Failed to resolve latest LTS version of Node.js, skipping installation"
          continue
        fi
        asdf install nodejs "$version"
        asdf set --home nodejs "$version"
        ;;
      *)
        asdf plugin add "$plugin"
        asdf install "$plugin" latest
        asdf set --home "$plugin" latest
        ;;
    esac
  done
}
