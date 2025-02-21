import 'dart:math';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';

import 'package:math_keyboard/math_keyboard.dart';

double convertdegreetoradian(MathFieldEditingController controller) {
  double degree = getDouble(controller);
  return degree * (pi / 180);
}

double convertradiantodegree(MathFieldEditingController controller) {
  double radian = getDouble(controller);
  return radian * (180 / pi);
}
