all: test
.PHONY: all test clean clobber

test: a.out
	./$<

a.out: main.cpp
	g++ -W -Wall -o $@ $<


clean:
clobber: clean
	rm -rf a.out
