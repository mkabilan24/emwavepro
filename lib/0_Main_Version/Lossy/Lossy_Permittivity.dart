import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Lossless/8_Lossless_WaveNumber.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/0_Main_Version/Lossless/4_Lossless_IntrinsicImpedance.dart';
import 'package:emwavepro/Archive/Calculations/complex_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//Lossless
void calc_permittivity() {
  //\varepsilon = \varepsilon_r \varepsilon_0
  if (relativepermittivity.isEmpty) {
    permittivity.clear();
    return;
  }
  double relativePermittivityValue = convertMathExpressionToDouble(relativepermittivity);
  double permittivityValue =
      relativePermittivityValue * permittivityOfFreeSpace;
  updateDouble(permittivity, permittivityValue);
  print("The Calculated Permittivity is $permittivityValue.");
}

//Lossy
void calc_complex_permittivity() {
  double permittivityValue = convertMathExpressionToDouble(permittivity);
  double conductivityValue = convertMathExpressionToDouble(conductivity);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);
  complexpermittivity =
      Complex(permittivityValue, conductivityValue / angularfreqValue);
  print("The Complex Permittivity is ${complexpermittivity.toString()}.");
}

class PermittivityDisplayWidget extends StatefulWidget {
  @override
  _PermittivityDisplayWidgetState createState() => _PermittivityDisplayWidgetState();
}

class _PermittivityDisplayWidgetState extends State<PermittivityDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                  controller: relativepermittivity,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (value) {
                    if (!onchange) {
                      setState(() {
                        onchange = true;
                        calc_permittivity();
                        calc_intrinsicimpedance();
                        calc_wavenumber();
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
        Math.tex(displayexpression(permittivity),
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