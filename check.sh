#!/bin/bash
set -e
clear
(
  cat "Main.scala" | grep '^>>> ' | cut -c5-
) |
  scala -language:higherKinds -language:implicitConversions |
  grep -A 999 '^Type :help for more information.$' |
  tail -n +3
