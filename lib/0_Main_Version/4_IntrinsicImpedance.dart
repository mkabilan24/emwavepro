import 'dart:math';
import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/2_LaTexExpressionFormatter.dart';
import 'package:emwavepro/Calculations/complex_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//\eta=\frac{\left|E_0\right|}{\left|H_0\right|}=\sqrt{\frac{\mu}{\varepsilon}}

//Lossless
void calc_intrinsicimpedance() {
  //\eta=\sqrt{\frac{\mu}{\varepsilon}}
  if (permittivity.isEmpty || permeability.isEmpty) {
    intrinsicimpedance.clear();
    return;
  }
  double permittivityValue = getDouble(permittivity);
  double permeabilityValue = getDouble(permeability);
  double intrinsicimpedanceValue = sqrt(permeabilityValue / permittivityValue);
  updateDouble(intrinsicimpedance, intrinsicimpedanceValue);
  print("The calculated Intrinsic impedance is $intrinsicimpedanceValue.");
  return;
}

void calc_E0() {
  double intrinsicimpedanceValue = getDouble(intrinsicimpedance);
  double magneticabsoluteH0Value = getDouble(magneticabsoluteH0);
  double electricabsoluteE0Value =
      intrinsicimpedanceValue * magneticabsoluteH0Value;
  updateDouble(electricabsoluteE0, electricabsoluteE0Value);
  print("|E_0| = $electricabsoluteE0Value.");
}

void calc_H0() {
  double intrinsicimpedanceValue = getDouble(intrinsicimpedance);
  double electricabsoluteE0Value = getDouble(electricabsoluteE0);
  double magneticabsoluteH0Value =
      electricabsoluteE0Value / intrinsicimpedanceValue;
  updateDouble(electricabsoluteE0, electricabsoluteE0Value);
  print("|H_0| = $magneticabsoluteH0Value.");
}

//Lossy
void calc_compleximpedance() {
  double permeabilityValue = getDouble(permeability);
  intrinsicimpedanceroots =
      (Complex.divide(Complex(permeabilityValue, 0), complexpermittivity))
          .nthRoots(2);
  print(
      '${intrinsicimpedanceroots[0].toString()}, ${intrinsicimpedanceroots[1].toString()}');
}

class IntrinsicImpedanceWidget extends StatefulWidget {
  @override
  _IntrinsicImpedanceWidgetState createState() =>
      _IntrinsicImpedanceWidgetState();
}

class _IntrinsicImpedanceWidgetState extends State<IntrinsicImpedanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                    controller: intrinsicimpedance,
                    decoration: const InputDecoration(
                      hintText: "Input",
                      border: InputBorder.none, // Remove the border
                    ),
                    keyboardType: MathKeyboardType.expression,
                    onChanged: (newvalue) {
                      setState(() {}); // Trigger a rebuild to update the UI
                    }),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
