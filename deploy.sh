#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

HUGO_VERSION="${HUGO_VERSION:-0.162.1}"
HUGO="${HUGO:-./.tools/hugo-${HUGO_VERSION}/hugo}"
MSG="${1:-Update site $(date)}"

ensure_hugo() {
  if [ ! -x "$HUGO" ]; then
    echo "Installing Hugo ${HUGO_VERSION}..."
    mkdir -p "$(dirname "$HUGO")"
    curl -L --fail \
      -o "$(dirname "$HUGO")/hugo.tar.gz" \
      "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
    tar -xzf "$(dirname "$HUGO")/hugo.tar.gz" -C "$(dirname "$HUGO")"
  fi
}

printf '\033[0;32mDeploying updates to GitHub...\033[0m\n'
ensure_hugo
"$HUGO"

git -C public add .
if git -C public diff --cached --quiet; then
  echo "No generated public changes to commit."
else
  git -C public commit -m "$MSG"
  public_commit="$(git -C public rev-parse HEAD)"
  git -C public checkout master
  git -C public merge "$public_commit"
fi

git -C public push

git add public
if git diff --cached --quiet -- public; then
  echo "No public submodule update to commit."
else
  git commit -s -m "Update public submodule" -- public
fi

git push
