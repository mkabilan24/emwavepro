import 'dart:math';

import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/2_LaTexExpressionFormatter.dart';
import 'package:emwavepro/0_Main_Version/3_Permeability.dart';
import 'package:emwavepro/0_Main_Version/4_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/5_IntrinsicImpedance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void set_freespace_properties() {
  print("Setting Free Space Properties");
  updateDouble(relativepermeability, 1);
  calc_permeability();
  updateDouble(relativepermittivity, 1);
  calc_permittivity();
  updateDouble(conductivity, 0);
  print("The value of Conductivity is ${displayexpression(conductivity)}.");
  calc_intrinsicimpedance();
  print("Free Space Properties Set");
}

class FreeSpacePropertiesDisplayWidget extends StatefulWidget {
  @override
  _FreeSpacePropertiesDisplayWidgetState createState() => _FreeSpacePropertiesDisplayWidgetState();
}

class _FreeSpacePropertiesDisplayWidgetState extends State<FreeSpacePropertiesDisplayWidget> {
  @override
  void initState() {
    super.initState();
    //set_freespace_properties();
  }

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