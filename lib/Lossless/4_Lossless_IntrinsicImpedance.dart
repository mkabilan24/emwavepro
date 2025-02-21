import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';

import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';

//Lossless
void calc_lossless_intrinsicimpedance() {
  //\eta=\sqrt{\frac{\mu}{\varepsilon}}
  if (lossless_permittivity.isEmpty || lossless_permeability.isEmpty) {
    lossless_intrinsicimpedance.clear();
    return;
  }
  double permittivityValue = getDouble(lossless_permittivity);
  double permeabilityValue = getDouble(lossless_permeability);
  double intrinsicimpedanceValue = sqrt(permeabilityValue / permittivityValue);
  updateDouble(lossless_intrinsicimpedance, intrinsicimpedanceValue);
  print("The Calculated Intrinsic Impedance is $intrinsicimpedanceValue.");
  return;
}

Widget Lossless_IntrinsicImpedanceDisplayWidget(context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Math.tex(
        '\\text{Intrinsic Impedance, }',
        textStyle: const TextStyle(fontSize: 18),
      ),
      const SizedBox(height: 15),
      Math.tex(
        '\\eta = \\sqrt{\\frac{\\mu}{\\varepsilon}} = \\sqrt{\\frac{\\mu_{r}}{\\varepsilon_{r}}} \\times 120\\pi = ',
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
                  controller: lossless_intrinsicimpedance,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (newvalue) {
                    onchange = true;
                    if (lossless_intrinsicimpedance.isEmpty) {
                      snackbarController.hideErrorSnackBar();
                    } else if (!inputHandler(lossless_intrinsicimpedance)) {
                      if (getDouble(lossless_intrinsicimpedance) >= 0) {
                        snackbarController.hideErrorSnackBar();
                      } else {
                        snackbarController.showPermanentErrorSnackBar(context,
                            "Input Error: Intrinsic Impedance (η) must be positive!");
                      }
                    } else {
                      snackbarController.showPermanentErrorSnackBar(
                          context, "Input Error: Intrinsic Impedance (η)");
                    }
                    onchange = false;
                  } // Trigger a rebuild to update the UI
                  ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Math.tex(
        '\\Omega',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}
