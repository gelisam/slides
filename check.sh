#!/bin/bash
set -e
clear
cat Main.scala > Main.elm
(
  echo "import Main exposing (..)"
  cat Main.elm | grep '^-- >>> ' | cut -c8-
) | elm-repl | tail -n +4 | sed 's/^> > //g' | sed 's/^> //g'
