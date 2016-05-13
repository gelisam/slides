#!/bin/bash
set -e
clear
cat Main.scala > Main.java
javac -Xlint:unchecked Main.java
CLASSPATH=. java Main
