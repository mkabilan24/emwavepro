import 'dart:math';

import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';

// Function to get the double value of the MathFieldEditingController
double getDouble(MathFieldEditingController controller) {
  if (checkifscientificnotation(controller)) {
    return getScientificNotationDoubleValue(controller);
  }
  else if (checkifEXPnotation(controller)) {
    return getEXPnotationDoubleValue(controller);
  }
  double value = double.parse(controller.currentEditingValue());
  return value;
}

// Function to check if the input is in EXP expression
bool checkifEXPnotation(MathFieldEditingController controller) {
  String ExpressionString = controller.currentEditingValue();
  print('Expression String: $ExpressionString');

  if (ExpressionString.contains('e')) {
    // Use a regular expression to extract the coefficient and exponent
    RegExp exp = RegExp(r'\^\{([0-9.]+)\}([+-]?[0-9]+)');
    RegExpMatch? match = exp.firstMatch(ExpressionString);
    if (match != null) {
      return true;
    }
    else {
      return false;
    }
  }
  else {
    return false;
  }
}

// Function to get the double value of the EXP expression
double getEXPnotationDoubleValue(MathFieldEditingController controller) {
  String ExpressionString = controller.currentEditingValue();
  print('Expression String: $ExpressionString');

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
  return 0;
}

// Function to check if the input is in scientific notation
bool checkifscientificnotation(MathFieldEditingController controller) {
  String expressionString = controller.currentEditingValue();
  print('Expression String: $expressionString');

  RegExp regex = RegExp(r'[+-]?\d+(\.\d+)?|\d+(\^{\d+})?');
  RegExpMatch? match = regex.firstMatch(expressionString);
  if (match != null) {
    //print("Scientific Notation Detected!");
    Iterable<RegExpMatch> matches = regex.allMatches(expressionString);
    List<String> extractedNumbers = matches.map((match) => match.group(0)!).toList();
    //print('Extracted Numbers: $extractedNumbers');
    if (extractedNumbers.length == 3 && !extractedNumbers.contains('\box')) { // Check if the extracted numbers are 3 and not empty
      return true;
    }
  }
  return false;
}

// Function to get the double value of the scientific notation
double getScientificNotationDoubleValue(MathFieldEditingController controller) {
  String expressionString = controller.currentEditingValue();
  print('Expression String: $expressionString');

  RegExp regex = RegExp(r'[+-]?\d+(\.\d+)?|\d+(\^{\d+})?');
  RegExpMatch? match = regex.firstMatch(expressionString);
  if (match != null) {
    //print("Scientific Notation Detected!");
    Iterable<RegExpMatch> matches = regex.allMatches(expressionString);
    List<String> extractedNumbers = matches.map((match) => match.group(0)!).toList();
    //print('Extracted Numbers: $extractedNumbers');
    if (extractedNumbers.length == 3 && !extractedNumbers.contains('\box')) { // Check if the extracted numbers are 3 and not empty
      // Resolve the Scientific Notation to Standard Number
      double standardnum = double.parse(extractedNumbers[0])*pow(double.parse(extractedNumbers[1]), double.parse(extractedNumbers[2]));
      //print('Standard Number: $standardnum');
      return standardnum;
    }
  }
  return 0;
}

void updateDouble(MathFieldEditingController controller, double value) {
  // ignore: deprecated_member_use
  final expression = Parser().parse(value.toString());
  controller.updateValue(expression);
}

// Function for handling errorneous inputs
// Purpose: To strictly accept only digits, a single decimal place, large and small numbers in scientific notation and empty controller so the app will not crash
bool inputHandler(MathFieldEditingController controller) {
  String expressionString = controller.currentEditingValue();
  print('Expression String: $expressionString');

  // Regular expression to match only digits and a single decimal place (Including + or - sign in front)
  RegExp validChars = RegExp(r'^[+-]?\d+(\.\d+)?$');

  if (controller.isEmpty) {
    return false;
  }
  else if (!validChars.hasMatch(expressionString)) {
    if (checkifscientificnotation(controller)) {
      return false;
    }
    print('Input Error Detected!');
    return true;
  }
  return false;
}