import 'dart:math';

// Class to represent a complex number
class Complex {
  final double real;
  final double imaginary;

  Complex(this.real, this.imaginary);

  // Function to compute magnitude
  double magnitude() {
    return sqrt(real * real + imaginary * imaginary);
  }

  // Function to compute argument
  double argument() {
    return atan2(imaginary, real);
  }

  // Function to get the real part of the complex number
  double getReal() {
    return real;
  }

  // Function to get the imaginary part of the complex number
  double getImaginary() {
    return imaginary;
  }

  bool isEmpty() {
    if (real == 0 && imaginary == 0) {
      return true;
    }
    return false;
  }

  // Function to compute n-th roots
  List<Complex> nthRoots(int n) {
    List<Complex> roots = [];
    double r = magnitude();
    double theta = argument();

    // Calculate the n-th root of the magnitude
    double rootMagnitude = pow(r, 1 / n).toDouble();

    for (int k = 0; k < n; k++) {
      // Calculate the angle for the current root
      double angle = (theta + 2 * pi * k) / n;
      // Calculate the real and imaginary parts of the root
      double realPart = rootMagnitude * cos(angle);
      double imaginaryPart = rootMagnitude * sin(angle);
      roots.add(Complex(realPart, imaginaryPart));
    }

    return roots;
  }

  // Static function to multiply two complex numbers
  static Complex multiply(Complex c1, Complex c2) {
    double newReal = c1.real * c2.real - c1.imaginary * c2.imaginary;
    double newImaginary = c1.real * c2.imaginary + c1.imaginary * c2.real;
    return Complex(newReal, newImaginary);
  }

  // Static function to divide two complex numbers
  static Complex divide(Complex c1, Complex c2) {
    double denominator = c2.real * c2.real + c2.imaginary * c2.imaginary;
    double newReal = (c1.real * c2.real + c1.imaginary * c2.imaginary) / denominator;
    double newImaginary = (c1.imaginary * c2.real - c1.real * c2.imaginary) / denominator;
    return Complex(newReal, newImaginary);
  }

  @override
  String toString() {
    // Format the real and imaginary parts
    String realPart = real.toString();
    String imaginaryPart = imaginary.abs().toString(); // Absolute value for imaginary part

    // Determine the sign to display
    String sign = imaginary >= 0 ? '+' : '-';

    // Construct the formatted string
    return '$realPart $sign ${imaginaryPart}j';
  }
}
