import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';

void calc_wavelength() {
  double phaseconstantValue = getDouble(phaseconstant);
  double wavelengthValue = (2*pi)/phaseconstantValue;
  updateDouble(wavelength, wavelengthValue);
  print("The calculated Wavelength is $wavelengthValue.");
}