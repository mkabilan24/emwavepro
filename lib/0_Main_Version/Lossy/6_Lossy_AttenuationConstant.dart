import 'dart:math';
import 'package:emwavepro/0_Main_Version/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//Lossy
void calc_lossy_attenuationconstant() {
  double freqValue = getDouble(freq);
  double permeabilityValue = getDouble(lossy_permeability);
  double conductivityValue = getDouble(lossy_conductivity);
  double attenuationconstantValue = sqrt(pi * freqValue * permeabilityValue * conductivityValue);
  updateDouble(lossy_attenuationconstant, attenuationconstantValue);
  print("The calculated Attenuation Constant is $attenuationconstantValue.");
}

// Widget Lossy_AttenuationConstantDisplayWidget() {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Row(children: [
//       Math.tex('\\text{Attenuation Constant, } \\alpha = 0', textStyle: const TextStyle(fontSize: 18),),
//     ]),
//   );
// }
