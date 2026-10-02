#!/usr/bin/env bash
# Copies the code examples that the docsrc topics coderef from the HTML and specialization plug-in samples,
# and the PDF topics from the PDF plug-in.
set -euo pipefail

cd "$(dirname "$0")"
HTML_DIR="${HTML_DIR:-../dita-bootstrap.html}"
SPEC_DIR="${SPEC_DIR:-../dita-bootstrap.specialization}"
PDF_DIR="${PDF_DIR:-../dita-bootstrap.pdf}"

for pair in "html:$HTML_DIR" "specialization:$SPEC_DIR"; do
  name="${pair%%:*}"
  src="${pair#*:}/sample/code"
  [ -d "$src" ] || { echo "Missing $src (set HTML_DIR / SPEC_DIR)" >&2; exit 1; }
  rm -rf "docsrc/html/code/$name"
  mkdir -p docsrc/html/code
  cp -R "$src" "docsrc/html/code/$name"
done

[ -d "$PDF_DIR/docsrc" ] || { echo "Missing $PDF_DIR/docsrc (set PDF_DIR)" >&2; exit 1; }
rm -rf docsrc/pdf
cp -R "$PDF_DIR/docsrc" docsrc/pdf
rm docsrc/pdf/document.ditamap
mkdir -p docsrc/pdf/code
cp -R docsrc/html/code/. docsrc/pdf/code/
