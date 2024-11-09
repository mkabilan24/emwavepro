import 'dart:math';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/0_Main_Version/Lossless/2_Lossless_Permeability.dart';
import 'package:emwavepro/0_Main_Version/Lossless/3_Lossless_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/Lossless/4_Lossless_IntrinsicImpedance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
class FreeSpacePropertiesDisplayWidget extends StatefulWidget {
  @override
  _FreeSpacePropertiesDisplayWidgetState createState() => _FreeSpacePropertiesDisplayWidgetState();
}

class _FreeSpacePropertiesDisplayWidgetState extends State<FreeSpacePropertiesDisplayWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Math.tex(
            '\\text{Permeability, }\\mu = \\mu_0 = 4\\pi*10^{-7}\\,H/m',
            textStyle: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Math.tex(
            '\\text{Permittivity, }\\varepsilon = \\varepsilon_0 = \\frac{1}{36\\pi}*10^{-9}\\,F/m',
            textStyle: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Math.tex(
            '\\text{Conductivity, }\\sigma = 0\\,S/m',
            textStyle: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Math.tex(
            '\\text{Intrinsic impedance, }\\eta = \\sqrt{\\frac{\\mu}{\\varepsilon}} = \\frac{E}{H} = 120\\pi \\approx 377\\,\\Omega',
            textStyle: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
        ],
      )
    );
  }
}