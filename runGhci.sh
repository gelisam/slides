#!/bin/bash
function allTheCode {
  grep '^> ' | cut -c3-
}

function lineCount {
  wc -l | tr -d ' \t'
}

function charCount {
  wc -c | tr -d ' \t'
}

function stripLastLine {
  local INPUT="$(cat)"
  local N="$(echo "$INPUT" | lineCount)"
  local M=$(($N - 1))
  
  if [ "$M" -gt 0 ]; then
    echo "$INPUT" | head -n "$M"
  fi
}

function lastLine {
  tail -n 1
}

function runGhci {
  ghci MiniPan.lhs
}

function stripPrefixAndSuffic {
  local INPUT="$(cat)"
  local PREFIX="$1"
  local SUFFIX="$2"
  
  local INPUT_LENGTH="$(echo "$INPUT" | charCount)"
  local PREFIX_LENGTH="$(echo "$PREFIX" | charCount)"
  local SUFFIX_LENGTH="$(echo "$SUFFIX" | charCount)"
  
  local START=$(($PREFIX_LENGTH))
  local END=$(($INPUT_LENGTH - $SUFFIX_LENGTH))
  
  echo "$INPUT" |
    tr '\n' '\1' |
    cut -c"$START"-"$END" |
    tr '\1' '\n'
}

CODE="$(cat "$@" | allTheCode)"

NUGGET_PRODUCING_CODE="$(echo "$CODE" | stripLastLine; echo 'putStrLn "NUGGET"')"
NUGGET_OUTPUT="$(echo "$NUGGET_PRODUCING_CODE" | runGhci)"
PREFIX="$(echo "$NUGGET_OUTPUT" | tr '\n' '\1' | sed 's/NUGGET.*//g' | tr '\1' '\n')"
SUFFIX="$(echo "$NUGGET_OUTPUT" | tr '\n' '\1' | sed 's/.*NUGGET//g' | tr '\1' '\n')"

echo "$CODE" | runGhci | stripPrefixAndSuffic "$PREFIX" "$SUFFIX"
