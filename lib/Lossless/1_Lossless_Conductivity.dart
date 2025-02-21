import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';

void calc_lossless_conductivity() {
  updateDouble(lossless_conductivity, 0);
}

Widget Lossless_ConductivityDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Math.tex(
        '\\text{Conductivity, }\\sigma = 0 \\text{ S/m}',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}
