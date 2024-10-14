import 'package:emwavepro/0_Main_Version/2_LaTexExpressionFormatter.dart';
import 'package:flutter/material.dart';
import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

void calc_permeability() {
  //\mu=\mu_r\mu_0
  if (relativepermeability.isEmpty) {
    permeability.clear();
    return;
  }
  double relativePermeabilityValue = getDouble(relativepermeability);

  double permeabilityValue =
      relativePermeabilityValue * permeabilityOfFreeSpace;
  updateDouble(permeability, permeabilityValue);
  print("The calculated permeability is $permeabilityValue.");
}

class PermeabilityWidget extends StatefulWidget {
  @override
  _PermeabilityWidgetState createState() => _PermeabilityWidgetState();
}

class _PermeabilityWidgetState extends State<PermeabilityWidget> {
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
                    controller: relativepermeability,
                    decoration: const InputDecoration(
                      hintText: "Input",
                      border: InputBorder.none, // Remove the border
                    ),
                    keyboardType: MathKeyboardType.expression,
                    onChanged: (newvalue) {
                      setState(() {
                        calc_permeability();
                      }); // Trigger a rebuild to update the UI
                    }),
              ),
            ),
          ),
        ),
        Math.tex(
          '\\mu_{0} = ',
          textStyle: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        if (!permeability.isEmpty)
          Math.tex(displayexpression(permeability.currentEditingValue()),
              textStyle: const TextStyle(fontSize: 18)),
      ]),
    );
  }
}
