import 'dart:math';
import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/Calculations/complex_math.dart';

//\eta=\frac{\left|E_0\right|}{\left|H_0\right|}=\sqrt{\frac{\mu}{\varepsilon}}

//Lossless
void calc_intrinsicimpedance() {
  //\eta=\sqrt{\frac{\mu}{\varepsilon}}
  double permittivityValue = getDouble(permittivity);
  double permeabilityValue = getDouble(permeability);
  double intrinsicimpedanceValue = sqrt(permeabilityValue/permittivityValue);
  updateDouble(intrinsicimpedance, intrinsicimpedanceValue);
  print("The calculated Intrinsic impedance is $intrinsicimpedanceValue.");
  return;
}

void calc_E0() {
  double intrinsicimpedanceValue = getDouble(intrinsicimpedance);
  double magneticabsoluteH0Value = getDouble(magneticabsoluteH0);
  double electricabsoluteE0Value = intrinsicimpedanceValue * magneticabsoluteH0Value;
  updateDouble(electricabsoluteE0, electricabsoluteE0Value);
  print("|E_0| = $electricabsoluteE0Value.");
}

void calc_H0() {
  double intrinsicimpedanceValue = getDouble(intrinsicimpedance);
  double electricabsoluteE0Value = getDouble(electricabsoluteE0);
  double magneticabsoluteH0Value = electricabsoluteE0Value / intrinsicimpedanceValue;
  updateDouble(electricabsoluteE0, electricabsoluteE0Value);
  print("|H_0| = $magneticabsoluteH0Value.");
}

//Lossy
void calc_compleximpedance() {
  double permeabilityValue = getDouble(permeability);
  intrinsicimpedanceroots = (Complex.divide(Complex(permeabilityValue, 0), complexpermittivity)).nthRoots(2);
  print('${intrinsicimpedanceroots[0].toString()}, ${intrinsicimpedanceroots[1].toString()}');
}

void main() {

}