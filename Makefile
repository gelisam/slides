all: test
.PHONY: all test clean clobber

test: main
	./main

main: main.rs
	rustc main.rs


clean:
clobber: clean
	rm -rf main
