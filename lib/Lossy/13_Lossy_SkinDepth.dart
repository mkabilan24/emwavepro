import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/LaTexExpressionFormatter.dart';

void calc_skindepth() {
  print("Calculating Skin Depth.");
  double attenuationconstantValue = getDouble(lossy_attenuationconstant);
  double skindepthValue = 1 / attenuationconstantValue;
  updateDouble(lossy_skindepth, skindepthValue);
  print("The calculated Skin Depth is $skindepthValue.");
}

Widget Lossy_SkindepthDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Math.tex(
        '\\text{Skin Depth, } \\delta = \\frac{1}{\\alpha} = ${(lossy_skindepth.isEmpty) ? 0 : displayexpression(lossy_skindepth)} \\:m',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}
