#!/bin/bash
set -e

ghcid --command="cabal repl -fobject-code slides" --test=main
