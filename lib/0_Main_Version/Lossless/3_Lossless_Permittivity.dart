import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';

import 'package:emwavepro/0_Main_Version/Lossless/8_Lossless_WaveNumber.dart';
import 'package:emwavepro/0_Main_Version/Lossless/4_Lossless_IntrinsicImpedance.dart';

//Lossless
void calc_lossless_permittivity() {
  //\varepsilon = \varepsilon_r \varepsilon_0
  if (lossless_relativepermittivity.isEmpty) {
    lossless_permittivity.clear();
    return;
  }
  double relativePermittivityValue = convertMathExpressionToDouble(lossless_relativepermittivity);
  double permittivityValue = relativePermittivityValue * permittivityOfFreeSpace;
  updateDouble(lossless_permittivity, permittivityValue);
  print("The Calculated Permittivity is $permittivityValue.");
}

class Lossless_PermittivityDisplayWidget extends StatefulWidget {
  @override
  _Lossless_PermittivityDisplayWidgetState createState() => _Lossless_PermittivityDisplayWidgetState();
}

class _Lossless_PermittivityDisplayWidgetState extends State<Lossless_PermittivityDisplayWidget> {
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
                  controller: lossless_relativepermittivity,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (value) {
                    if (!onchange) {
                      setState(() {
                        onchange = true;
                        calc_lossless_permittivity();
                        calc_lossless_intrinsicimpedance();
                        calc_lossless_wavenumber();
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
        Math.tex(displayexpression(lossless_permittivity),
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