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

#else

// Opaque type as a C proxy for the class.
typedef struct Rational Rational;

#endif // __cplusplus

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

Rational *make_rational(int numer, int denom);
int get_numer(const Rational *r);
int get_denom(const Rational *r);
void del_rational(Rational **rp);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus
