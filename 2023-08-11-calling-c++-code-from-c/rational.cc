#include "rational.h"

extern "C" void *make_rational(int numer, int denom) {
  try {
    // Allocate an instance on the heap.
    Rational *r = new Rational(numer, denom);
    return r;
  } catch (...) {
    return nullptr;
  }
}

extern "C" int get_numer(void *r) {
  // Cast to access members.
  Rational *_r = static_cast<Rational*>(r);
  return _r->_numer;
}

extern "C" int get_denom(void *r) {
  Rational *_r = static_cast<Rational*>(r);
  return _r->_denom;
}

extern "C" void del_rational(void **rp) {
  Rational *_r = static_cast<Rational*>(*rp);
  delete _r;

  // Delete the dangling pointer too.
  *rp = nullptr;
}
