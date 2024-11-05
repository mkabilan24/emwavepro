import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';

//Lossless
void calc_lossless_attenuationconstant() {
  updateDouble(lossless_attenuationconstant, 0);
}

Widget Lossless_AttenuationConstantDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Math.tex('\\text{Attenuation Constant, } \\alpha = 0\\text{ Np/m}', textStyle: const TextStyle(fontSize: 18),),
    ]),
  );
}
