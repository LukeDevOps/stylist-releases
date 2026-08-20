#!/usr/bin/env bash
# Fetches the pinned stylist release binary (verified against
# SHA256SUMS), caches it, and runs the pre-commit hook. Bump VERSION
# here on every stylist release; it deliberately doesn't self-detect
# its version from git, since pre-commit's shallow clone can't
# reliably `git describe` the checked-out rev.
set -euo pipefail

VERSION="v1.0.0"
REPO="lukedevops/stylist-releases"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/stylist-hook/$VERSION"
BIN="$CACHE_DIR/stylist"

os=""
case "$(uname -s)" in
  Darwin) os=darwin ;;
  Linux) os=linux ;;
  MINGW*|MSYS*|CYGWIN*) os=windows ;;
  *) echo "stylist-hook: unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

arch=""
case "$(uname -m)" in
  x86_64|amd64) arch=amd64 ;;
  arm64|aarch64) arch=arm64 ;;
  *) echo "stylist-hook: unsupported arch: $(uname -m)" >&2; exit 1 ;;
esac

asset="stylist-$VERSION-$os-$arch"
[ "$os" = windows ] && asset="$asset.exe"

if [ ! -x "$BIN" ]; then
  mkdir -p "$CACHE_DIR"
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT

  # The v1.0.0 release asset is actually named with this exact suffix
  # (verified against the live GitHub release, not just the docs'
  # generic "SHA256SUMS file" wording) — don't "fix" this to plain
  # SHA256SUMS, that file 404s.
  sums="stylist-$VERSION-SHA256SUMS.txt"
  base_url="https://github.com/$REPO/releases/download/$VERSION"
  curl -fsSL -o "$tmp/$asset" "$base_url/$asset"
  curl -fsSL -o "$tmp/$sums" "$base_url/$sums"

  if command -v sha256sum >/dev/null 2>&1; then
    ( cd "$tmp" && grep " $asset\$" "$sums" | sha256sum -c - )
  else
    ( cd "$tmp" && grep " $asset\$" "$sums" | shasum -a 256 -c - )
  fi

  chmod +x "$tmp/$asset"
  mv "$tmp/$asset" "$BIN"
fi

exec "$BIN" hook pre-commit "$@"
