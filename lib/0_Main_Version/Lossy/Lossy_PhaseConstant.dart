import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//Lossless
void calc_lossless_phaseconstant() {
  double wavenumberValue = convertMathExpressionToDouble(wavenumber);
  double phaseconstantValue = wavenumberValue; //Good Conductor
  updateDouble(phaseconstant, phaseconstantValue);
  print("The calculated Phase Constant is $phaseconstantValue.");
}

//If Good Consuctor
void calc_phaseconstant() {
  double attenuationconstantValue = getDouble(attenuationconstant);
  double phaseconstantValue = attenuationconstantValue; //Good Conductor
  updateDouble(phaseconstant, phaseconstantValue);
  print("The calculated Phase Constant is $phaseconstantValue.");
}

Widget Lossless_PhaseConstantDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(children: [
      Math.tex(
        '\\text{Phase Constant, } \\beta = k = ',
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
                  controller: phaseconstant,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (newvalue) {
                    // Trigger a rebuild to update the UI
                  }),
            ),
          ),
        ),
      ),
    ]),
  );
}
