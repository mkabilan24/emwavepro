import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/Complex_Math.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';

//Lossy
String calc_complex_impedance() {
  if (lossy_permeability.isEmpty || complexpermittivity == Complex(0, 0)) {
    return '0\\:\\Omega';
  }
  double permeabilityValue = getDouble(lossy_permeability);
  intrinsicimpedanceroots =
      (Complex.divide(Complex(permeabilityValue, 0), complexpermittivity))
          .nthRoots(2);
  print(
      "The Complex Intrinsic Impedance Roots are: ${intrinsicimpedanceroots[0].toString()}, ${intrinsicimpedanceroots[1].toString()}.");
  //Set the first root as the intrinsic impedance
  complexintrinsicimpedance = intrinsicimpedanceroots[0];
  return '${intrinsicimpedanceroots[0].toString()} \\: \\Omega, ${intrinsicimpedanceroots[1].toString()} \\: \\Omega';
}

class Lossy_Complex_IntrinsicImpedanceDisplayWidget extends StatefulWidget {
  @override
  _Lossy_Complex_IntrinsicImpedanceDisplayWidgetState createState() =>
      _Lossy_Complex_IntrinsicImpedanceDisplayWidgetState();
}

class _Lossy_Complex_IntrinsicImpedanceDisplayWidgetState
    extends State<Lossy_Complex_IntrinsicImpedanceDisplayWidget> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(children: [
        Math.tex(
          '\\text{Complex Intrinsic impedance, } \\eta_{c} = \\sqrt{\\frac{\\mu}{\\varepsilon_{c}}} = ${calc_complex_impedance()}',
          textStyle: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
