#!/usr/bin/env bash

set -euo pipefail

REPORT_URL="https://github.com/4thel00z/asdf-sq/issues"
GH_REPO="https://github.com/neilotoole/sq"
TOOL_NAME="sq"
TOOL_TEST="sq --help"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  awk 'BEGIN{ FS="-" } { if ($0 ~ /beta/) {print $1" 1 "$0} else if ($0 ~ /rc/) { print $1" 2 "$0 } else { print $1" 3 "$0 } }' |
    LC_ALL=C sort --reverse | awk '{print $3}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

latest_version() {
  local query
  query="$1"
  [ -z "$query" ] && query="[0-9]"
  list_all_versions | sort_versions | grep "$query" | head -n 1
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  case $(uname | tr '[:upper:]' '[:lower:]') in
    linux*)
      local platform="linux-amd64.tar.gz"
      ;;
    darwin*)
      local platform="darwin-amd64.tar.gz"
      ;;
    *)
      fail "Platform download not supported. Please, open an issue at $REPORT_URL"
      ;;
  esac

  url="$GH_REPO/releases/download/v${version}/${TOOL_NAME}-${version}-${platform}"

  echo "* Downloading $TOOL_NAME release $version from $url to $filename"
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin"
    echo "* Executing tar xzf $ASDF_DOWNLOAD_PATH/*.tar.gz -C $install_path/bin"
    ls $ASDF_DOWNLOAD_PATH

    tar xzf "$ASDF_DOWNLOAD_PATH"/*.tar.gz -C "$install_path/bin"
    echo "* ls $install_path/bin"
    ls $install_path/bin
    chmod +x "$install_path/bin/$TOOL_NAME"

    local tool_cmd
    tool_cmd=$TOOL_NAME
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
