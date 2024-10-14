import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';

void calc_skindepth() {
  double attenuationconstantValue = getDouble(attenuationconstant);
  double skindepthValue = 1/attenuationconstantValue;
  updateDouble(skindepth, skindepthValue);
  print("The calculated Skin Depth is $skindepthValue.");
}