import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';

import 'package:emwavepro/0_Main_Version/Lossless/8_Lossless_WaveNumber.dart';
import 'package:emwavepro/0_Main_Version/Lossless/4_Lossless_IntrinsicImpedance.dart';

//Lossless
void calc_lossless_permeability() {
  //\mu=\mu_r\mu_0
  if (lossless_relativepermeability.isEmpty) {
    lossless_permeability.clear();
    return;
  }
  double relativePermeabilityValue = convertMathExpressionToDouble(lossless_relativepermeability);
  double permeabilityValue = relativePermeabilityValue * permeabilityOfFreeSpace;
  updateDouble(lossless_permeability, permeabilityValue);
  print("The Calculated Permeability is $permeabilityValue.");
}
class Lossless_PermeabilityDisplayWidget extends StatefulWidget {
  @override
  _Lossless_PermeabilityDisplayWidgetState createState() => _Lossless_PermeabilityDisplayWidgetState();
}

class _Lossless_PermeabilityDisplayWidgetState extends State<Lossless_PermeabilityDisplayWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        Math.tex(
          '\\text{Permeability, }\\mu = \\mu_{r}\\mu_{0} = ',
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
                  controller: lossless_relativepermeability,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (value) {
                    if (!onchange) {
                      setState(() {
                        onchange = true;
                        calc_lossless_permeability();
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
          '\\mu_{0} = ',
          textStyle: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        Math.tex(displayexpression(lossless_permeability),
            textStyle: const TextStyle(fontSize: 18)),
        Math.tex(
          '\\text{ H/m}',
          textStyle: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}

