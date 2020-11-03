#!/usr/bin/env bash
# Reproducible build with a TeX Live close to the original submission (2020).
# openout_any=a lets bibtex (TL2020) write its log to the absolute output dir.
# Requires podman (or docker: export ENGINE=docker). Output: build/main.pdf
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=${IMAGE:-docker.io/texlive/texlive:TL2020-historic}
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out main.tex
