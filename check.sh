#!/bin/bash
set -e
clear
cat Main.scala > Main.cpp
g++ --std=c++11 -W -Wall Main.cpp
./a.out
