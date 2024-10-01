import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';

//If Good Consuctor
void calc_phaseconstant() {
  double attenuationconstantValue = getDouble(attenuationconstant);
  double phaseconstantValue = attenuationconstantValue; //Good Conductor
  updateDouble(phaseconstant, phaseconstantValue);
  print("The calculated Phase Constant is $phaseconstantValue.");
}