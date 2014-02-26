all: test build

test: build
	./hello

build: hello

hello: hello.c
	gcc $< -o $@
