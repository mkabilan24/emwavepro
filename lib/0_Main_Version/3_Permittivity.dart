import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/2_LaTexExpressionFormatter.dart';
import 'package:emwavepro/Calculations/complex_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//Lossless
void calc_permittivity() {
  //\varepsilon = \varepsilon_r \varepsilon_0
  if (relativepermittivity.isEmpty) {
    permittivity.clear();
    return;
  }
  double relativePermittivityValue = convertMathExpressionToDouble(relativepermittivity);
  double permittivityValue =
      relativePermittivityValue * permittivityOfFreeSpace;
  updateDouble(permittivity, permittivityValue);
  print("The Calculated Permittivity is $permittivityValue.");
}

//Lossy
void calc_complex_permittivity() {
  double permittivityValue = convertMathExpressionToDouble(permittivity);
  double conductivityValue = convertMathExpressionToDouble(conductivity);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);
  complexpermittivity =
      Complex(permittivityValue, conductivityValue / angularfreqValue);
  print("The Complex Permittivity is ${complexpermittivity.toString()}.");
}

Widget PermittivityDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(children: [
      Math.tex(
        '\\text{Permittivity, }\\varepsilon = \\varepsilon_{r}\\varepsilon_{0} = ',
        textStyle: const TextStyle(fontSize: 18),
      ),
      const SizedBox(width: 10),
      Container(
        width: 100, // Set the fixed width
        height: 40, // Set the fixed height
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Add border if needed
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 100, // Ensure minimum width matches container width
            ),
            child: IntrinsicWidth(
              child: MathField(
                controller: relativepermittivity,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: InputBorder.none, // Remove the border
                ),
                keyboardType: MathKeyboardType.expression,
              ),
            ),
          ),
        ),
      ),
      Math.tex(
        '\\varepsilon_{0} = ',
        textStyle: const TextStyle(fontSize: 18),
      ),
      const SizedBox(width: 10),
      Math.tex(displayexpression(permittivity),
          textStyle: const TextStyle(fontSize: 18)),
      const SizedBox(width: 10),
      Math.tex(
        ' F/m',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}
