import 'package:emwavepro/Lossy/8_Lossy_PropagationConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/Lossy/14_Lossy_WaveNumber.dart';
import 'package:emwavepro/Lossy/7_Lossy_IntrinsicImpedance.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';

//Lossless
void calc_lossy_permeability() {
  //\mu=\mu_r\mu_0
  if (lossy_relativepermeability.isEmpty) {
    lossy_permeability.clear();
    return;
  }
  double relativePermeabilityValue = convertMathExpressionToDouble(lossy_relativepermeability);
  double permeabilityValue = relativePermeabilityValue * permeabilityOfFreeSpace;
  updateDouble(lossy_permeability, permeabilityValue);
  print("The Calculated Permeability is $permeabilityValue.");
}
class Lossy_PermeabilityDisplayWidget extends StatefulWidget {
  @override
  _Lossy_PermeabilityDisplayWidgetState createState() => _Lossy_PermeabilityDisplayWidgetState();
}

class _Lossy_PermeabilityDisplayWidgetState extends State<Lossy_PermeabilityDisplayWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                  controller: lossy_relativepermeability,
                  decoration: const InputDecoration(
                    hintText: "Input",
                    border: InputBorder.none, // Remove the border
                  ),
                  keyboardType: MathKeyboardType.expression,
                  onChanged: (value) {
                    if (!onchange) {
                      setState(() {
                        onchange = true;
                        calc_lossy_permeability();
                        calc_wave_number_roots();
                        calc_propagation_constant();
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
        Math.tex(displayexpression(lossy_permeability),
            textStyle: const TextStyle(fontSize: 18)),
        Math.tex(
          '\\text{ H/m}',
          textStyle: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}

