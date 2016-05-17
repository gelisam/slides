#!/bin/bash
set -e
clear
(
  cat "Main.scala" | grep '^// >>> ' | cut -c8-
) |
  scala -language:higherKinds -language:implicitConversions -i Main.scala |
  grep -A 999 '^Type :help for more information.$' |
  tail -n +3
