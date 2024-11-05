import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';

void calc_wavelength() {
  double phaseconstantValue = getDouble(phaseconstant);
  double wavelengthValue = (2*pi)/phaseconstantValue;
  updateDouble(wavelength, wavelengthValue);
  print("The calculated Wavelength is $wavelengthValue.");
}