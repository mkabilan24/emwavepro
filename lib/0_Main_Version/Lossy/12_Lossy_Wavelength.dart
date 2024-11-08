import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void calc_wavelength() {
  double phaseconstantValue = getDouble(lossy_phaseconstant);
  double wavelengthValue = (2*pi)/phaseconstantValue;
  updateDouble(lossy_wavelength, wavelengthValue);
  print("The calculated Wavelength is $wavelengthValue.");
}

Widget Lossy_WavelengthDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: 
      Row(children: [
        Math.tex('\\text{Wavelength, } \\lambda = \\frac{2\\pi}{\\beta} = ${(lossy_wavelength.isEmpty) ? 0 : displayexpression(lossy_wavelength)} \\:m', textStyle: const TextStyle(fontSize: 18),),
      ]),
    );
}