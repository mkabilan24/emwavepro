import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:math_keyboard/math_keyboard.dart';

String determinepolarisation(MathFieldEditingController EH1Controller, MathFieldEditingController EH2Controller, MathFieldEditingController phi1Controller, MathFieldEditingController phi2Controller) {

  if (EH1Controller.isEmpty || EH2Controller.isEmpty) {
    return "None";
  }

  double EH01 = convertMathExpressionToDouble(EH1Controller);
  double EH02 = convertMathExpressionToDouble(EH2Controller);
  double phi1 = 0;
  double phi2 = 0;

  if (!phi1Controller.isEmpty) {
    phi1 = convertMathExpressionToDouble(phi1Controller);
  }
  if (!phi2Controller.isEmpty) {
    phi2 = convertMathExpressionToDouble(phi2Controller);
  }

  if ((EH01 == 0) || (EH02 == 0)) {
    return "Linear";
  }
  double absolutePhaseDiff = (phi1 - phi2).abs();
  if ((absolutePhaseDiff == 0) || (absolutePhaseDiff == 180)) {
    return "Linear";
  }
  if ((absolutePhaseDiff == 90) && (EH01 == EH02)) {
    return "Circular";
  }
  return "Elliptical";
}