#!/bin/bash
set -e

clear
if [ "$(head -n1 slides.md)" = '#lang "klister.kl"' ]; then
  export KLISTERPATH="$HOME/working/haskell/klister/examples"
  klister run slides.md
  echo
  echo
  echo
fi
