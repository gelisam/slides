#!/bin/bash
set -e

./run.sh
fswatcher --path klister.kl --path slides.md --throttle 300 -- ./run.sh
