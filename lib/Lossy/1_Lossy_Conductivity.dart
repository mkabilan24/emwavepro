import 'package:emwavepro/Lossy/5_LossTangent.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/Lossy/6_Lossy_Complex_Permittivity.dart';

Widget Lossy_ConductivityDisplayWidget(context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Math.tex(
        '\\text{Conductivity, }\\sigma \\neq 0 = ',
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
                controller: lossy_conductivity,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: InputBorder.none, // Remove the border
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (value) {
                  if (lossy_conductivity.isEmpty) {
                    snackbarController.hideErrorSnackBar();
                  }
                  if (!inputHandler(lossy_conductivity)) {
                    if (getDouble(lossy_conductivity) >= 0) {
                      calc_complex_permittivity();
                      calc_losstangent();
                      snackbarController.hideErrorSnackBar();
                    } else {
                      snackbarController.showPermanentErrorSnackBar(context,
                          "Input Error: Conductivity (σ) must be positive!");
                    }
                  } else {
                    snackbarController.showPermanentErrorSnackBar(
                        context, "Input Error: Conductivity (σ)");
                  }
                },
              ),
            ),
          ),
        ),
      ),
      Math.tex(
        '\\text{ S/m}',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}
