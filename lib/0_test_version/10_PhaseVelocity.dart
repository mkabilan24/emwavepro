import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';

void calc_phasevelocity() {
  double angularfreqValue = getDouble(angularfreq);
  double phaseconstantValue = getDouble(phaseconstant);
  double phasevelocityValue = angularfreqValue/phaseconstantValue;
  updateDouble(phasevelocity, phasevelocityValue);
  print("The calculated Phase Velocity is $phasevelocityValue.");
}