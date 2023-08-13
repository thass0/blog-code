#include "rational.h"

extern "C" {
  Rational *make_rational(int numer, int denom) {
    try {
      // Allocate an instance on the heap.
      Rational *r = new Rational(numer, denom);
      return r;
    } catch (...) {
      return nullptr;
    }
  }

  int get_numer(const Rational *r) {
    // Cast to access members.
    return r->_numer;
  }

  int get_denom(const Rational *r) {
    return r->_denom;
  }

  void del_rational(Rational **rp) {
    delete *rp;

    // Delete the dangling pointer too.
    *rp = nullptr;
  }
}
