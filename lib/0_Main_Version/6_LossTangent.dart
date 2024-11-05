import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';

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

