import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/Calculations/complex_math.dart';

//Lossless
void calc_permittivity() {
  //\varepsilon = \varepsilon_r \varepsilon_0
  double relativePermittivityValue = getDouble(relativepermittivity);
  double permittivityValue = relativePermittivityValue * permittivityOfFreeSpace;
  updateDouble(permittivity, permittivityValue);
  print("The calculated permittivity is $permittivityValue.");
}

//Lossy
void calc_complex_permittivity() {
  double permittivityValue = getDouble(permittivity);
  double conductivityValue = getDouble(conductivity);
  double angularfreqValue = getDouble(angularfreq);
  complexpermittivity = Complex(permittivityValue, conductivityValue/angularfreqValue);
  print("The Complex Permittivity is ${complexpermittivity.toString()}.");
}
