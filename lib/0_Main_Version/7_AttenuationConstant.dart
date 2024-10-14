import 'dart:math';
import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';

void calc_attenuationconstant() {
  double freqValue = getDouble(freq);
  double permeabilityValue = getDouble(permeability);
  double conductivityValue = getDouble(conductivity);
  double attenuationconstantValue = sqrt(pi * freqValue * permeabilityValue * conductivityValue);
  updateDouble(attenuationconstant, attenuationconstantValue);
  print("The calculated Attenuation Constant is $attenuationconstantValue.");
}