import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';

import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';


//Lossless
void calc_lossless_phaseconstant() {
  if (lossless_wavenumber.isEmpty) {
    lossless_phaseconstant.clear();
    return;
  }
  double wavenumberValue = getDouble(lossless_wavenumber);
  double phaseconstantValue = wavenumberValue;
  updateDouble(lossless_phaseconstant, phaseconstantValue);
  print("The calculated Phase Constant is $phaseconstantValue.");
}

void sync_lossless_phaseconstant_wavenumber() {
  if (lossless_phaseconstant.isEmpty) {
    lossless_wavenumber.clear();
    return;
  }
  double phaseconstantValue = getDouble(lossless_phaseconstant);
  updateDouble(lossless_wavenumber, phaseconstantValue);
  print("The calculated Wave Number is $phaseconstantValue.");
}

Widget Lossless_PhaseConstantDisplayWidget(context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
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
                  controller: lossless_phaseconstant,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (newvalue) {                      
                    onchange = true;
                    if (lossless_phaseconstant.isEmpty) {
                      sync_lossless_phaseconstant_wavenumber();
                      snackbarController.hideErrorSnackBar();
                    }

                    else if (!inputHandler(lossless_phaseconstant)) {
                      if (getDouble(lossless_phaseconstant) >= 0) {
                        sync_lossless_phaseconstant_wavenumber();
                        snackbarController.hideErrorSnackBar();
                      }
                      else {
                        snackbarController.showPermanentErrorSnackBar(
                            context, "Input Error: Phase Constant (β) must be positive!");
                      }
                    }
                    else {
                      snackbarController.showPermanentErrorSnackBar(
                          context, "Input Error: Phase Constant (β)");
                    }
                    onchange = false;
                    }
                  ),
            ),
          ),
        ),
      ),
      Math.tex(
        '\\text{ rad/m}',
        textStyle: const TextStyle(fontSize: 18),
      )
    ]),
  );
}
