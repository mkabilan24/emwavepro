import 'dart:math';
import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/Calculations/complex_math.dart';

//Lossless
void calc_wavenumber() {
  double permittivityValue = getDouble(permittivity);
  double permeabilityValue = getDouble(permeability);
  double angularfreqValue = getDouble(angularfreq);
  double wavenumberValue = sqrt(pow(angularfreqValue, 2) * permittivityValue * permeabilityValue);
  updateDouble(wavenumber, wavenumberValue);
  print("The calculated Wave Number is $wavenumberValue.");
}

//Lossy
void calc_complexwavenumber() {
  double permittivityValue = getDouble(permittivity);
  double permeabilityValue = getDouble(permeability);
  double angularfreqValue = getDouble(angularfreq);
  double conductivityValue = getDouble(conductivity);

  double realvalue = pow(angularfreqValue, 2) * permeabilityValue * permittivityValue;
  double imaginaryvalue = pow(angularfreqValue, 2) * permeabilityValue * (conductivityValue/angularfreqValue);

  Complex z = Complex(realvalue, -imaginaryvalue);

  // Compute the 2 roots of the complex number
  waveNumberRoots = z.nthRoots(2);
  complexwavenumber_root1 = waveNumberRoots[0];
  complexwavenumber_root2 = waveNumberRoots[1];
  print("The value of Complex Wave Number Root 1 is: ${complexwavenumber_root1.toString()}");
  print("The value of Complex Wave Number Root 2 is: ${complexwavenumber_root2.toString()}");
}