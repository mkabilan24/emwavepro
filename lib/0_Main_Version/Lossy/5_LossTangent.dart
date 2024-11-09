import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:emwavepro/0_Main_Version/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';

void calc_losstangent() {
  if (lossy_conductivity.isEmpty || angularfreq.isEmpty || lossy_permittivity.isEmpty) {
    losstangent.clear();
    return;
  }
  double conductivityValue = convertMathExpressionToDouble(lossy_conductivity);
  double angularfreqValue = convertMathExpressionToDouble(angularfreq);
  double permittivityValue = convertMathExpressionToDouble(lossy_permittivity);

  double losstangentValue = conductivityValue/(angularfreqValue * permittivityValue);
  updateDouble(losstangent, losstangentValue);
  print("The calculated Loss Tangent is $losstangentValue.");
  isGoodConductor = determineifGoodConductor();
}

bool determineifGoodConductor() {
  double losstangentValue = convertMathExpressionToDouble(losstangent);
  if (losstangentValue > conductivitymargin) {
    return true;
  }
  else {
    return false;
  }
}

Widget Lossy_LosstangentDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Math.tex(
        '\\text{Loss Tangent, }\\frac{\\sigma}{\\omega\\varepsilon}= ${losstangent.isEmpty ? 0 : displayexpression(losstangent)}',
        textStyle: const TextStyle(fontSize: 18),
      ),
      Text(
        isGoodConductor ? ' > $conductivitymargin (Good Conductor)' : ' < $conductivitymargin (Bad Conductor)',
        style: TextStyle(fontSize: 18, color: isGoodConductor ? Colors.green : Colors.red),
      ),
    ]),
  );
}