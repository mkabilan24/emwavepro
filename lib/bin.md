// Function to evaluate mathematical expressions
// double getDouble(MathFieldEditingController controller) {

//   String ExpressionString = controller.currentEditingValue();
//   // Debugging: Print the input string
//   // print('Expression String: $ExpressionString');

//   // Check if the string contains 'e'
//   if (ExpressionString.contains('e')) {
//     // Use a regular expression to extract the coefficient and exponent
//     RegExp exp = RegExp(r'\^\{([0-9.]+)\}([+-]?[0-9]+)');
//     RegExpMatch? match = exp.firstMatch(ExpressionString);
//     if (match != null) {
//       double coefficient = double.parse(match.group(1)!);
//       //print("Double Coefficient: $coefficient");
//       double exponent = double.parse(match.group(2)!);
//       //print("Double Exponent: $exponent");
//       double value = coefficient * pow(10, exponent);
//       //print("Doulbe Value: $value");
//       return value;
//     }
//   }
//   // If the string does not contain 'e' or is not a very big or small number, return the original string
//   return getDouble(controller);
// }