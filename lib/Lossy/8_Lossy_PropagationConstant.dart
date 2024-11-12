import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/Shared/Complex_Math.dart';
import 'package:emwavepro/Lossy/9_Lossy_AttenuationConstant.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Lossy/10_Lossy_PhaseConstant.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';

void calc_propagation_constant() {
    if (waveNumberRoots.isEmpty) {
      return;
    }

  //IMPORTANTIMPORTANTIMPORTANTIMPORTANTIMPORTANT
  //Assumption: Taking only the first root
  Complex wave_number_root = waveNumberRoots[0];
  print("Taking only the first root: $wave_number_root");

  //propagation_constant = wave_number_root * j
  propagation_constant = Complex.multiply(wave_number_root, Complex(0, 1));
  print("The value of Propagation Constant is: ${propagation_constant.toString()}");
  updateDouble(lossy_attenuationconstant, propagation_constant.getReal());
  set_lossy_attenuationconstant();
  updateDouble(lossy_phaseconstant, propagation_constant.getImaginary());
  set_lossy_phaseconstant();
}

class Lossy_PropagationConstantDisplayWidget extends StatefulWidget {
  @override
  _Lossy_PropagationConstantDisplayWidgetState createState() => _Lossy_PropagationConstantDisplayWidgetState();
}

class _Lossy_PropagationConstantDisplayWidgetState extends State<Lossy_PropagationConstantDisplayWidget> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: 
          Row(children: [
          Math.tex(
            '\\text{Propagation Constant, } \\gamma = \\alpha + j\\beta = j \\omega \\sqrt{\\mu\\varepsilon_{c}} = ${propagation_constant.toString()}',
            textStyle: const TextStyle(fontSize: 18),
          ),
        ]),
      );
  }
}