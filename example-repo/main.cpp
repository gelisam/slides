#include <stdio.h>

/* Greet the given person or entity.
 * 
 * >>> say_hello("world")
 * hello world
 */
void say_hello(char* to_whom) {
  printf("hello %s\n", to_whom);
}

int main() {
  say_hello("world!");
  return 0;
}
