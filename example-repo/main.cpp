#include <stdio.h>

void say_hello(char* to_whom) {
  printf("hello %s\n", to_whom);
}

int main() {
  say_hello("worlp");
  return 0;
}
