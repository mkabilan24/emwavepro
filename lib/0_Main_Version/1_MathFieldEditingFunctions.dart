import 'dart:math';

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

// Function to evaluate mathematical expressions
double convertMathExpressionToDouble(MathFieldEditingController controller) {

  String ExpressionString = controller.currentEditingValue();
  // Debugging: Print the input string
  //print('Expression String: $ExpressionString');

  // Check if the string contains 'e'
  if (ExpressionString.contains('e')) {
    // Use a regular expression to extract the coefficient and exponent
    RegExp exp = RegExp(r'\^\{([0-9.]+)\}([+-]?[0-9]+)');
    RegExpMatch? match = exp.firstMatch(ExpressionString);
    if (match != null) {
      double coefficient = double.parse(match.group(1)!);
      //print("Double Coefficient: $coefficient");
      double exponent = double.parse(match.group(2)!);
      //print("Double Exponent: $exponent");
      double value = coefficient * pow(10, exponent);
      //print("Doulbe Value: $value");
      return value;
    }
  }

  // Try to parse the string as a double
  // double? value = double.tryParse(ExpressionString);
  // if (value != null) {
  //   // Convert to scientific notation
  //   String scientificString = value.toStringAsExponential();
  //   // Use a regular expression to extract the coefficient and exponent
  //   RegExp exp = RegExp(r'([0-9.]+)e([+-]?[0-9]+)');
  //   RegExpMatch? match = exp.firstMatch(scientificString);
  //   if (match != null) {
  //     String coefficient = match.group(1)!;
  //     String exponent = match.group(2)!;
  //     String latexString = '$coefficient \\times 10^{$exponent}';
  //     print('LaTeX String: $latexString');
  //     return latexString;
  //   }
  // }
  
  // If the string does not contain 'e' or is not a very big or small number, return the original string
  return getDouble(controller);
}