#include <stdio.h>
#include "rational.h"

int main(void) {
  Rational *r = make_rational(5, 3);
  if (r == NULL) {
    printf("Denominator is 0\n");
    return -1;
  } else {
    printf("I'm a C program\n");
    printf("%d / %d\n", get_numer(r), get_denom(r));
    del_rational(&r);
    return 0;
  }
}
