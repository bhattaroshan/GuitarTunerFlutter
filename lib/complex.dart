import 'dart:math';

class Complex {
  final double re;
  final double im;

  Complex(this.re, this.im);

  double abs() {
    return sqrt(re * re + im * im);
  }

  double phase() {
    return atan2(im, re);
  }

  Complex plus(Complex b) {
    Complex a = Complex(re, im);
    double real = a.re + b.re;
    double imag = a.im + b.im;
    return Complex(real, imag);
  }

  Complex minus(Complex b) {
    Complex a = Complex(re, im);
    double real = a.re - b.re;
    double imag = a.im - b.im;
    return Complex(real, imag);
  }

  Complex times(Complex b) {
    Complex a = Complex(re, im);
    double real = a.re * b.re - a.im * b.im;
    double imag = a.re * b.im + a.im * b.re;
    return Complex(real, imag);
  }

  Complex scale(double alpha) {
    return Complex(alpha * re, alpha * im);
  }

  Complex conjugate() {
    return Complex(re, -im);
  }

  double real() {
    return re;
  }

  double imag() {
    return im;
  }

  Complex dualPlus(Complex a, Complex b) {
    double real = a.re + b.re;
    double imag = a.im + b.im;
    Complex sum = Complex(real, imag);
    return sum;
  }
}
