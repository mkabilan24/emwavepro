import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/0_Main_Version/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Lossy/11_Lossy_PhaseVelocity.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Lossy/12_Lossy_Wavelength.dart';

//Lossy
void set_lossy_phaseconstant() {
  if (lossy_phaseconstant.isEmpty) {
    return;
  }
  double phaseconstantValue = getDouble(lossy_phaseconstant);
  print("The Phase Constant is $phaseconstantValue.");
  calc_lossy_phasevelocity();
  calc_wavelength();
}

Widget Lossy_PhaseConstantDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: 
      Row(children: [
        Math.tex('\\text{Phase Constant, } \\beta = ${(lossy_phaseconstant.isEmpty) ? 0 : displayexpression(lossy_phaseconstant)} \\:rad/m \\text{ > k}', textStyle: const TextStyle(fontSize: 18),),
      ]),
    );
}