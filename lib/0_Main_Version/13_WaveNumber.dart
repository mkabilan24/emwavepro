import 'dart:math';
import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/2_LaTexExpressionFormatter.dart';
import 'package:emwavepro/0_Main_Version/8_PhaseConstant.dart';
import 'package:emwavepro/Calculations/complex_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//Lossless
void calc_wavenumber() {
  if (permittivity.isEmpty || permeability.isEmpty || angularfreq.isEmpty) {
    wavenumber.clear();
    return;
  }
  double permittivityValue = convertMathExpressionToDouble(permittivity);
  double permeabilityValue = convertMathExpressionToDouble(permeability);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);
  double wavenumberValue = sqrt(pow(angularfreqValue, 2) * permittivityValue * permeabilityValue);
  updateDouble(wavenumber, wavenumberValue);
  print("The calculated Wave Number is $wavenumberValue.");
  print("The calculated Wave Number is ${displayexpression(wavenumber)}.");
  calc_lossless_phaseconstant();
}

//Lossy
void calc_complexwavenumber() {
  double permittivityValue = convertMathExpressionToDouble(permittivity);
  double permeabilityValue = convertMathExpressionToDouble(permeability);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);
  double conductivityValue = convertMathExpressionToDouble(conductivity);

  double realvalue = pow(angularfreqValue, 2) * permeabilityValue * permittivityValue;
  double imaginaryvalue = pow(angularfreqValue, 2) * permeabilityValue * (conductivityValue/angularfreqValue);

  Complex z = Complex(realvalue, -imaginaryvalue);

  // Compute the 2 roots of the complex number
  waveNumberRoots = z.nthRoots(2);
  complexwavenumber_root1 = waveNumberRoots[0];
  complexwavenumber_root2 = waveNumberRoots[1];
  print("The value of Complex Wave Number Root 1 is: ${complexwavenumber_root1.toString()}");
  print("The value of Complex Wave Number Root 2 is: ${complexwavenumber_root2.toString()}");
}

Widget WaveNumberDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(children: [
      Math.tex(
        '\\text{Wave Number, }k = \\sqrt{\\omega^{2}\\mu\\varepsilon} = ',
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
                controller: wavenumber,
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
    ]),
  );
}