all: test
.PHONY: all test clean clobber

test: a.out
	./$<

a.out: hello.c
	gcc -W -Wall -o $@ $<


clean:
clobber: clean
	rm -rf a.out
