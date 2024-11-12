import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/Shared/Complex_Math.dart';
import 'package:emwavepro/Lossy/8_Lossy_PropagationConstant.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';


String calc_wave_number_roots() {
  if (angularfreq.isEmpty || lossy_permeability.isEmpty || lossy_permittivity.isEmpty || lossy_conductivity.isEmpty) {
    waveNumberRoots = [];
    return "0";
  }
  double permittivityValue = convertMathExpressionToDouble(lossy_permittivity);
  double permeabilityValue = convertMathExpressionToDouble(lossy_permeability);
  double conductivityValue = convertMathExpressionToDouble(lossy_conductivity);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);

  double realvalue = pow(angularfreqValue, 2) * permeabilityValue * permittivityValue;
  double imaginaryvalue = pow(angularfreqValue, 2) * permeabilityValue * conductivityValue / angularfreqValue;

  Complex z = Complex(realvalue, -imaginaryvalue);

  // Compute the 2 roots of the complex number
  waveNumberRoots = z.nthRoots(2);
  print("The Complex WaveNumber Roots are: $waveNumberRoots");
  calc_propagation_constant();
  return '${waveNumberRoots[0].toString()}, ${waveNumberRoots[1].toString()}';
}

class Lossy_WaveNumberDisplayWidget extends StatefulWidget {
  @override
  _Lossy_WaveNumberDisplayWidgetState createState() => _Lossy_WaveNumberDisplayWidgetState();
}

class _Lossy_WaveNumberDisplayWidgetState extends State<Lossy_WaveNumberDisplayWidget> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: 
          Row(children: [
          Math.tex(
            '\\text{Wave Number, } k_{c} = \\sqrt{\\omega^{2}\\mu\\varepsilon_{c}} = ${calc_wave_number_roots()}',
            textStyle: const TextStyle(fontSize: 18),
          ),
        ]),
      );
  }
}