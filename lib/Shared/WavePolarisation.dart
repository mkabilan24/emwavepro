import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:math_keyboard/math_keyboard.dart';

String determinepolarisation(MathFieldEditingController EH1Controller, MathFieldEditingController EH2Controller, MathFieldEditingController phi1Controller, MathFieldEditingController phi2Controller) {

  if (numofcomponents == 1) {
    return "Linear";
  }

  if (EH1Controller.isEmpty && EH2Controller.isEmpty) {
    return "None";
  }

  if ((convertMathExpressionToDouble(EH1Controller) == 0) || (convertMathExpressionToDouble(EH2Controller) == 0)) {
    return "Linear";
  }

  double phi1 = 0;
  double phi2 = 0;

  if (!phi1Controller.isEmpty) {
    phi1 = convertMathExpressionToDouble(phi1Controller);
  }
  if (!phi2Controller.isEmpty) {
    phi2 = convertMathExpressionToDouble(phi2Controller);
  }
  double absolutePhaseDiff = (phi1 - phi2).abs();
  if ((absolutePhaseDiff == 0) || (absolutePhaseDiff == 180)) {
    return "Linear";
  }

  if ((absolutePhaseDiff == 90) && (convertMathExpressionToDouble(EH1Controller) == convertMathExpressionToDouble(EH2Controller))) {
    return "Circular";
  }
  
  return "Elliptical";
}