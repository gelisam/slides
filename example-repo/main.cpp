#include <stdio.h>

// Greet the given person or entity
void say_hello(char* to_whom) {
  printf("hello %s\n", to_whom);
}

int main() {
  say_hello("world!");
  return 0;
}
