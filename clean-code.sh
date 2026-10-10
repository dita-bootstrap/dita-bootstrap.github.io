#!/usr/bin/env bash
# Removes what copy-code.sh copies into docsrc. Images in docsrc/html/src are only
# removed if they exist in the HTML plug-in's sample/src, so other images are kept.
set -euo pipefail

cd "$(dirname "$0")"
HTML_DIR="${HTML_DIR:-../dita-bootstrap.html}"
src="$HTML_DIR/sample/src"
[ -d "$src" ] || { echo "Missing $src (set HTML_DIR)" >&2; exit 1; }

rm -rf docsrc/html/code/html docsrc/html/code/specialization docsrc/pdf
rmdir docsrc/html/code 2>/dev/null || true

(cd "$src" && find . -type f) | while read -r f; do
  rm -f "docsrc/html/src/$f"
done
find docsrc/html/src -mindepth 1 -type d -empty -delete 2>/dev/null || true
