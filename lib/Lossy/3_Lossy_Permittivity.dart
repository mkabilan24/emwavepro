import 'package:emwavepro/Lossy/5_LossTangent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/Lossy/6_Lossy_Complex_Permittivity.dart';
import 'package:emwavepro/Lossy/14_Lossy_WaveNumber.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';

//Lossless
void calc_lossy_permittivity() {
  //\varepsilon = \varepsilon_r \varepsilon_0
  if (lossy_relativepermittivity.isEmpty) {
    lossy_permittivity.clear();
    return;
  }
  double relativePermittivityValue = getDouble(lossy_relativepermittivity);
  double permittivityValue = relativePermittivityValue * permittivityOfFreeSpace;
  updateDouble(lossy_permittivity, permittivityValue);
  print("The Calculated Permittivity is $permittivityValue.");
}

class Lossy_PermittivityDisplayWidget extends StatefulWidget {
  @override
  _Lossy_PermittivityDisplayWidgetState createState() => _Lossy_PermittivityDisplayWidgetState();
}

class _Lossy_PermittivityDisplayWidgetState extends State<Lossy_PermittivityDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                  controller: lossy_relativepermittivity,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (value) {
                    if (!onchange) {
                      setState(() {
                        onchange = true;
                        if (lossy_relativepermittivity.isEmpty) {
                          lossy_permittivity.clear();
                          snackbarController.hideErrorSnackBar();
                        }
                        else if (!inputHandler(lossy_relativepermittivity)) {
                          if (getDouble(lossy_relativepermittivity) >= 0) {
                            calc_losstangent();
                            calc_lossy_permittivity();
                            calc_complex_permittivity();
                            calc_wave_number_roots();
                            snackbarController.hideErrorSnackBar();
                          }
                          else {
                            snackbarController.showPermanentErrorSnackBar(
                                context, "Input Error: Permittivity (ε) must be positive!");
                          }
                        }
                        else {
                          snackbarController.showPermanentErrorSnackBar(
                              context, "Input Error: Permittivity (ε)");
                        }
                        onchange = false;
                      });
                    }
                  },
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
        Math.tex(displayexpression(lossy_permittivity),
            textStyle: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Math.tex(
          '\\text{ F/m}',
          textStyle: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}