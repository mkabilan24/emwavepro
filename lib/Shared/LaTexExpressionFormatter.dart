import 'package:emwavepro/Shared/Settings_GlobalVariables.dart';
import 'package:math_keyboard/math_keyboard.dart';

String displayexpression(MathFieldEditingController controller) {
  if (controller.isEmpty) {
    return '';
  }
  String expressionString = controller.currentEditingValue();
  //print("The expression string is $expressionString.");

  // Check if the string contains 'e'
  if (expressionString.contains('e')) {
    // Use a regular expression to extract the coefficient and exponent
    RegExp exp = RegExp(r'\^\{([+-]?[0-9.]+)\}([+-]?[0-9]+)');
    RegExpMatch? match = exp.firstMatch(expressionString);
    if (match != null) {
      String coefficient = double.parse(match.group(1)!).toStringAsFixed(decimalPlaces);
      String exponent = match.group(2)!;
      String latexString = '$coefficient \\times 10^{$exponent}';
      return latexString;
    }
  }

  // Try to parse the string as a double
  double? value = double.tryParse(expressionString);
  if (value != null) {
    // Convert to scientific notation
    String scientificString = value.toStringAsExponential(decimalPlaces);
    // Use a regular expression to extract the coefficient and exponent
    RegExp exp = RegExp(r'([+-]?[0-9.]+)e([+-]?[0-9]+)');
    RegExpMatch? match = exp.firstMatch(scientificString);
    if (match != null) {
      String coefficient = double.parse(match.group(1)!).toStringAsFixed(decimalPlaces);
      String exponent = match.group(2)!;
      //print("The coefficient is $coefficient and the exponent is $exponent.");
      
      int exponentValue = int.parse(exponent);
      if (exponentValue >= 3) {
        String latexString = '$coefficient \\times 10^{$exponentValue}';
        return latexString;
      }

      if (exponentValue <= -3) {
        String latexString = '$coefficient \\times 10^{$exponent}';
        return latexString;
      }
    }
  }
  
  // If the string does not contain 'e' or is not a very big or small number, return the original string formatted to decimal places
  double? originalValue = double.tryParse(expressionString);
  if (originalValue != null) {
    return originalValue.toStringAsFixed(decimalPlaces);
  }
  
  return expressionString;
}