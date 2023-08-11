#ifdef __cplusplus

#include <stdexcept>

class Rational {
public:
  int _numer;
  int _denom;

  Rational(int numer, int denom) {
    this->_numer = numer;
    if (denom == 0) {
      throw std::domain_error("denominator is 0");
    } else {
      this->_denom = denom;
    }
  }
};
#endif  // __cplusplus

#ifdef __cplusplus
#define extern_c extern "C"
#else
#define extern_c
#endif  // __cplusplus

extern_c void *make_rational(int numer, int denom);
extern_c int get_numer(void *r);
extern_c int get_denom(void *r);
extern_c void del_rational(void **rp);

#undef extern_c
