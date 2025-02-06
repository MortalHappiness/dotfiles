#!/usr/bin/env bash

plugins=(
  "lazydocker"
  "fzf"
  "dust"
  "nodejs"
  "golang"
  "rust"
  "kubectl"
  "k9s"
  "helm"
  "minikube"
  "kind"
  "k3d"
  "kustomize"
)

for plugin in "${plugins[@]}"; do
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
