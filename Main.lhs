> let scaledBy p (sx,sy) = p `At` (X/sx, Y/sy)
> let translatedBy p (dx,dy) = p `At` (X-dx, Y-dy)
> let minOf p1 p2 = (p1 `Leq` p2) * p1 + (p2 `Lt` p1) * p2

> let rightMustache = ((R + X) `At` (0.5*Phi,R)) `translatedBy` (1,0.6)
> let leftMustache = rightMustache `scaledBy` (-1,1)
> let mustache = minOf leftMustache rightMustache
> compilePan $ mustache `scaledBy` (0.5, 0.5)
#include <math.h>
#include <stdio.h>

int main() {
  for(int y=0; y<20; ++y) {
    for(int x=0; x<40; ++x) {
      float v = (sqrt(0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI) * (0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI)) + sqrt((x / 0.5 / (0.0 - 1.0) - 1.0) * (x / 0.5 / (0.0 - 1.0) - 1.0) + (y / 0.5 / 1.0 - 0.6) * (y / 0.5 / 1.0 - 0.6)) * sqrt((x / 0.5 / (0.0 - 1.0) - 1.0) * (x / 0.5 / (0.0 - 1.0) - 1.0) + (y / 0.5 / 1.0 - 0.6) * (y / 0.5 / 1.0 - 0.6))) + 0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI) <= sqrt(0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI) * (0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI)) + sqrt((x / 0.5 - 1.0) * (x / 0.5 - 1.0) + (y / 0.5 - 0.6) * (y / 0.5 - 0.6)) * sqrt((x / 0.5 - 1.0) * (x / 0.5 - 1.0) + (y / 0.5 - 0.6) * (y / 0.5 - 0.6))) + 0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI)) * (sqrt(0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI) * (0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI)) + sqrt((x / 0.5 / (0.0 - 1.0) - 1.0) * (x / 0.5 / (0.0 - 1.0) - 1.0) + (y / 0.5 / 1.0 - 0.6) * (y / 0.5 / 1.0 - 0.6)) * sqrt((x / 0.5 / (0.0 - 1.0) - 1.0) * (x / 0.5 / (0.0 - 1.0) - 1.0) + (y / 0.5 / 1.0 - 0.6) * (y / 0.5 / 1.0 - 0.6))) + 0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI)) + (sqrt(0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI) * (0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI)) + sqrt((x / 0.5 - 1.0) * (x / 0.5 - 1.0) + (y / 0.5 - 0.6) * (y / 0.5 - 0.6)) * sqrt((x / 0.5 - 1.0) * (x / 0.5 - 1.0) + (y / 0.5 - 0.6) * (y / 0.5 - 0.6))) + 0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI) < sqrt(0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI) * (0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI)) + sqrt((x / 0.5 / (0.0 - 1.0) - 1.0) * (x / 0.5 / (0.0 - 1.0) - 1.0) + (y / 0.5 / 1.0 - 0.6) * (y / 0.5 / 1.0 - 0.6)) * sqrt((x / 0.5 / (0.0 - 1.0) - 1.0) * (x / 0.5 / (0.0 - 1.0) - 1.0) + (y / 0.5 / 1.0 - 0.6) * (y / 0.5 / 1.0 - 0.6))) + 0.5 * (atan2(y / 0.5 / 1.0 - 0.6, x / 0.5 / (0.0 - 1.0) - 1.0) / M_PI)) * (sqrt(0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI) * (0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI)) + sqrt((x / 0.5 - 1.0) * (x / 0.5 - 1.0) + (y / 0.5 - 0.6) * (y / 0.5 - 0.6)) * sqrt((x / 0.5 - 1.0) * (x / 0.5 - 1.0) + (y / 0.5 - 0.6) * (y / 0.5 - 0.6))) + 0.5 * (atan2(y / 0.5 - 0.6, x / 0.5 - 1.0) / M_PI));
      if      (v <= -0.75) printf("O");
      else if (v <= -0.25) printf("o");
      else if (v <=  0.25) printf(".");
      else if (v <=  0.75) printf("+");
      else                 printf("*");
    }
    printf("\n");
  }
  
  return 0;
}

$ gcc -O3 --std=c99 -W -Wall mustache.c -o mustache
$ time ./mustache > /dev/null
40% faster than the Haskell version!

































































