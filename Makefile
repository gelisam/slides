NAME="$(shell basename `pwd`)"

.PHONY: all config build doc test small-tests clean clobber

all: build doc test

config: dist/setup-config

dist/setup-config:
	cabal-dev install-deps
	cabal-dev configure

build: config
	cabal-dev build | cat
	@cabal-dev build &> /dev/null

doc: build
	find src -name '*.hs' | xargs haddock --optghc='-package-db '"$$(ls -d cabal-dev/packages-*.conf)" --no-warnings --odir=doc --html


test: small-tests

small-tests: build
	find src -name '*.hs' | xargs doctest
	#-package-db "$$(ls -d cabal-dev/packages-*.conf)"
	@echo


clean:
	rm -rf proofs *.class

clobber: clean
	rm -rf dist doc

distclean: clobber
	rm -rf cabal-dev
