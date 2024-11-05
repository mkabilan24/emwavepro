import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';

void calc_lossless_E0() {
  if (lossless_intrinsicimpedance.isEmpty || magneticabsoluteH0.isEmpty) {
    electricabsoluteE0.clear();
    return;
  }
  double intrinsicimpedanceValue = convertMathExpressionToDouble(lossless_intrinsicimpedance);
  double magneticabsoluteH0Value = convertMathExpressionToDouble(magneticabsoluteH0);
  double electricabsoluteE0Value = intrinsicimpedanceValue * magneticabsoluteH0Value;
  updateDouble(electricabsoluteE0, electricabsoluteE0Value);
  print("|E₀| = $electricabsoluteE0Value.");
}

Widget H0DisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Math.tex(
        "\\text{Amplitude of H-Field, H₀ = }",
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
                controller: magneticabsoluteH0,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: InputBorder.none, // Remove the border
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (value) {
                  if (!onchange) {
                    onchange = true;
                    calc_lossless_E0();
                    onchange = false;
                  }
                },
              ),
            ),
          ),
        ),
      ),
      Math.tex(
        '\\text{ A/m}',
        textStyle: const TextStyle(fontSize: 18),
      )
    ]),
  );
}