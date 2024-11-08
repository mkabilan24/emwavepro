import 'package:emwavepro/0_Main_Version/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void calc_lossy_phasevelocity() {
  if (angularfreq.isEmpty || lossy_phaseconstant.isEmpty) {
    return;
  }
  double phaseconstantValue = convertMathExpressionToDouble(lossy_phaseconstant);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);
  double phasevelocityValue = angularfreqValue / phaseconstantValue;
  updateDouble(lossy_phasevelocity, phasevelocityValue);
  print("The Phase Velocity is $phasevelocityValue.");
}

Widget Lossy_PhaseVelocityDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: 
      Row(children: [
        Math.tex('\\text{Phase Velocity, } \\upsilon_{p} = \\frac{\\omega}{\\beta} = ${(lossy_phasevelocity.isEmpty) ? 0 : displayexpression(lossy_phasevelocity)} \\:m/s', textStyle: const TextStyle(fontSize: 18),),
      ]),
    );
}