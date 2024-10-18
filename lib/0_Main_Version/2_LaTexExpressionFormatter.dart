//This function is to display very big or very small numbers in scientific notation
import 'package:math_keyboard/math_keyboard.dart';

String displayexpression(MathFieldEditingController controller) {

  if (controller.isEmpty) {
    return '';
  }
  String ExpressionString = controller.currentEditingValue();
  // Debugging: Print the input string
  //print('Expression String: $ExpressionString');

  // Check if the string contains 'e'
  if (ExpressionString.contains('e')) {
    // Use a regular expression to extract the coefficient and exponent
    RegExp exp = RegExp(r'\^\{([+-]?[0-9.]+)\}([+-]?[0-9]+)');
    RegExpMatch? match = exp.firstMatch(ExpressionString);
    if (match != null) {
      String coefficient = match.group(1)!;
      String exponent = match.group(2)!;
      String latexString = '$coefficient \\times 10^{$exponent}';
      return latexString;
    }
  }

  // Try to parse the string as a double
  double? value = double.tryParse(ExpressionString);
  if (value != null) {
    // Convert to scientific notation
    String scientificString = value.toStringAsExponential();
    // Use a regular expression to extract the coefficient and exponent
    RegExp exp = RegExp(r'([+-]?[0-9.]+)e([+-]?[0-9]+)');
    RegExpMatch? match = exp.firstMatch(scientificString);
    if (match != null) {
      String coefficient = match.group(1)!;
      String exponent = match.group(2)!;
      
      int exponentValue = int.parse(exponent);
      if (exponentValue >= 3 || exponentValue <= -3) {
        String latexString = '$coefficient \\times 10^{$exponent}';
        //print('LaTeX String: $latexString');
        return latexString;
      }
    }
  }
  
  // If the string does not contain 'e' or is not a very big or small number, return the original string
  return ExpressionString;
}