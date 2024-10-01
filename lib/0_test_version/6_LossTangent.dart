import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';

void calc_losstangent() {
  double conductivityValue = getDouble(conductivity);
  double angularfreqValue = getDouble(angularfreq);
  double permittivityValue = getDouble(permittivity);

  double losstangentValue = conductivityValue/(angularfreqValue * permittivityValue);
  updateDouble(losstangent, losstangentValue);
  print("The calculated Loss Tangent is $losstangentValue.");
}

bool determineifGoodConductor() {
  double losstangentValue = getDouble(losstangent);
  if (losstangentValue > conductivitymargin) {
    return true;
  }
  else {
    return false;
  }
}