import 'dart:math';
import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//Lossless
void calc_lossless_attenuationconstant() {
  updateDouble(attenuationconstant, 0);
}

//Lossy
void calc_attenuationconstant() {
  double freqValue = getDouble(freq);
  double permeabilityValue = getDouble(permeability);
  double conductivityValue = getDouble(conductivity);
  double attenuationconstantValue = sqrt(pi * freqValue * permeabilityValue * conductivityValue);
  updateDouble(attenuationconstant, attenuationconstantValue);
  print("The calculated Attenuation Constant is $attenuationconstantValue.");
}

Widget Lossless_AttenuationConstantDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(children: [
      Math.tex('\\text{Attenuation Constant, } \\alpha = 0', textStyle: const TextStyle(fontSize: 18),),
    ]),
  );
}
