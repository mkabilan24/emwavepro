import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/LaTexExpressionFormatter.dart';

import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';

import 'package:emwavepro/Lossless/7_Lossless_PhaseConstant.dart';

//Lossless
void calc_lossless_wavenumber() {
  if (lossless_permittivity.isEmpty || lossless_permeability.isEmpty || angularfreq.isEmpty) {
    lossless_wavenumber.clear();
    lossless_phaseconstant.clear();
    return;
  }
  double permittivityValue = convertMathExpressionToDouble(lossless_permittivity);
  double permeabilityValue = convertMathExpressionToDouble(lossless_permeability);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);
  double wavenumberValue = sqrt(pow(angularfreqValue, 2) * permittivityValue * permeabilityValue);
  updateDouble(lossless_wavenumber, wavenumberValue);
  print("The calculated Wave Number is $wavenumberValue.");
  print("The calculated Wave Number is ${displayexpression(lossless_wavenumber)}.");
  calc_lossless_phaseconstant();
}

// void _validateWavenumber(
  //     BuildContext context, MathFieldEditingController controller) {
  //   double? wavenumber = convertMathExpressionToDouble(controller);
  //   if (wavenumber < 0) {
  //     snackbarController.showTemporaryErrorSnackBar(
  //         context, "Wavenumber (k) must be positive!");
  //     controller.clear();
  //   }
  // }

Widget Lossless_WaveNumberDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
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
                controller: lossless_wavenumber,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: InputBorder.none, // Remove the border
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (value) {
                  if (!onchange) {
                    onchange = true;
                    if (!errorneousInputFilter(lossless_wavenumber)) {
                      calc_lossless_phaseconstant();
                    }
                    onchange = false;
                  }
                },
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}