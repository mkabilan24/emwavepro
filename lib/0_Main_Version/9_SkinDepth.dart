import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';

void calc_skindepth() {
  double attenuationconstantValue = getDouble(attenuationconstant);
  double skindepthValue = 1/attenuationconstantValue;
  updateDouble(skindepth, skindepthValue);
  print("The calculated Skin Depth is $skindepthValue.");
}