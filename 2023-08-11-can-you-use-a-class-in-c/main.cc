#include <iostream>
#include "rational.h"

auto main() -> int {
  auto r = Rational(5, 3);
  std::cout << "I'm a C++ program" << std::endl;
  std::cout << r._numer << " / " << r._denom << std::endl;
  return 0;
}
