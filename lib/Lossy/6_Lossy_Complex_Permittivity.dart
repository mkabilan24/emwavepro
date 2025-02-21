import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/Shared/Complex_Math.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Lossy/7_Lossy_IntrinsicImpedance.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';

//Lossy

void calc_complex_permittivity() {
  if (lossy_permittivity.isEmpty ||
      lossy_conductivity.isEmpty ||
      angularfreq.isEmpty) {
    complexpermittivity = Complex(0, 0);
    return;
  }
  double permittivityValue = getDouble(lossy_permittivity);
  double conductivityValue = getDouble(lossy_conductivity);
  double angularfreqValue = getDouble(angularfreq);
  complexpermittivity =
      Complex(permittivityValue, -(conductivityValue / angularfreqValue));
  print("The Complex Permittivity is ${complexpermittivity.toString()}.");
  calc_complex_impedance();
}

class Lossy_Complex_PermittivityDisplayWidget extends StatefulWidget {
  @override
  _Lossy_Complex_PermittivityDisplayWidgetState createState() =>
      _Lossy_Complex_PermittivityDisplayWidgetState();
}

class _Lossy_Complex_PermittivityDisplayWidgetState
    extends State<Lossy_Complex_PermittivityDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(children: [
        Math.tex(
          '\\text{Complex Permittivity, } \\varepsilon_{c} = \\varepsilon - j \\frac{\\sigma}{\\omega} = ${complexpermittivity.displayComplexExpression()}',
          textStyle: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        Math.tex(
          '\\text{ F/m}',
          textStyle: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
