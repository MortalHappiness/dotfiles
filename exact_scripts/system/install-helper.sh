# Helper functions

parse_latest_release() {
  curl -s "https://api.github.com/repos/$1/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*'
}
