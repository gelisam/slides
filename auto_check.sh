#!/bin/bash
set -s
clear
./check.sh
fswatcher --throttle=100 --path Main.scala ./check.sh
