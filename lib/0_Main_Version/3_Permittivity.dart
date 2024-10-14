import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/2_LaTexExpressionFormatter.dart';
import 'package:emwavepro/Calculations/complex_math.dart';
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
  double relativePermittivityValue = getDouble(relativepermittivity);
  double permittivityValue = relativePermittivityValue * permittivityOfFreeSpace;
  updateDouble(permittivity, permittivityValue);
  print("The Calculated Permittivity is $permittivityValue.");
}

//Lossy
void calc_complex_permittivity() {
  double permittivityValue = getDouble(permittivity);
  double conductivityValue = getDouble(conductivity);
  double angularfreqValue = getDouble(angularfreq);
  complexpermittivity = Complex(permittivityValue, conductivityValue/angularfreqValue);
  print("The Complex Permittivity is ${complexpermittivity.toString()}.");
}

class PermittivityWidget extends StatefulWidget {
  @override
  _PermittivityWidgetState createState() => _PermittivityWidgetState();
}

class _PermittivityWidgetState extends State<PermittivityWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
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
                      onChanged: (newvalue) {
                        setState(() {
                          calc_permittivity();
                        }); // Trigger a rebuild to update the UI
                      }),
                ),
              ),
            ),
          ),
          Math.tex(
            '\\varepsilon_{0} = ',
            textStyle: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 10),
          if (!permittivity.isEmpty)
            Math.tex(displayexpression(permittivity.currentEditingValue()), textStyle: const TextStyle(fontSize: 18)),
        ]),
      );
  }
}