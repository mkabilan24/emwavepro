import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';

double getDouble(MathFieldEditingController mathfieldvariable) {
  double value = double.parse(mathfieldvariable.currentEditingValue());
  return value;
}

void updateDouble(MathFieldEditingController mathfieldvariable, double value) {
  final expression = Parser().parse(value.toString());
  mathfieldvariable.updateValue(expression);
}