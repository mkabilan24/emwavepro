import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';

void calc_permeability() {
  //\mu=\mu_r\mu_0
  double relativePermeabilityValue = getDouble(relativepermeability);
  
  double permeabilityValue = relativePermeabilityValue * permeabilityOfFreeSpace;
  updateDouble(permeability, permeabilityValue);
  print("The calculated permeability is $permeabilityValue.");
}
