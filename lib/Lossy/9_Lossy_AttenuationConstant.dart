import 'dart:math';
import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/Lossy/13_Lossy_SkinDepth.dart';
import 'package:emwavepro/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

//Lossy
//Not in use
void calc_lossy_attenuationconstant() {
  double freqValue = getDouble(freq);
  double permeabilityValue = getDouble(lossy_permeability);
  double conductivityValue = getDouble(lossy_conductivity);
  double attenuationconstantValue = sqrt(pi * freqValue * permeabilityValue * conductivityValue);
  updateDouble(lossy_attenuationconstant, attenuationconstantValue);
  print("The calculated Attenuation Constant is $attenuationconstantValue.");
}

void set_lossy_attenuationconstant() {
  if (lossy_attenuationconstant.isEmpty) {
    return;
  }
  //notifier
  double attenuationconstantValue = getDouble(lossy_attenuationconstant);
  calc_skindepth();
  print("The Attenuation Constant is $attenuationconstantValue.");
}

Widget Lossy_AttenuationConstantDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child:
      Row(children: [
        Math.tex('\\text{Attenuation Constant, } \\alpha = ${(lossy_attenuationconstant.isEmpty) ? 0 : displayexpression(lossy_attenuationconstant)} \\:Np/m \\:\\neq\\:0', textStyle: const TextStyle(fontSize: 18),),
      ]),
    );
}
