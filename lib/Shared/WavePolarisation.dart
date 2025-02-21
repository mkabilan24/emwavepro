import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';

import 'package:emwavepro/Shared/DegreesandRadians.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/Settings_GlobalVariables.dart';

String determinepolarisation(
    MathFieldEditingController EH1Controller,
    MathFieldEditingController EH2Controller,
    MathFieldEditingController phi1Controller,
    MathFieldEditingController phi2Controller) {
  if (numofcomponents == 1) {
    return "Linear";
  }

  if (EH1Controller.isEmpty && EH2Controller.isEmpty) {
    return "None";
  }

  if ((getDouble(EH1Controller) == 0) || (getDouble(EH2Controller) == 0)) {
    return "Linear";
  }

  double phi1 = 0;
  double phi2 = 0;

  if (!phi1Controller.isEmpty) {
    if (isDegree) {
      phi1 = getDouble(phi1Controller);
    } else {
      phi1 = convertradiantodegree(phi1Controller);
    }
  }
  if (!phi2Controller.isEmpty) {
    if (isDegree) {
      phi2 = getDouble(phi2Controller);
    } else {
      phi2 = convertradiantodegree(phi2Controller);
    }
  }
  double absolutePhaseDiff = (phi1 - phi2).abs();
  if ((absolutePhaseDiff == 0) || (absolutePhaseDiff == 180)) {
    return "Linear";
  }

  if ((absolutePhaseDiff == 90) &&
      (getDouble(EH1Controller) == getDouble(EH2Controller))) {
    return "Circular";
  }

  return "Elliptical";
}

String reasonforpolarisation(
    MathFieldEditingController EH1Controller,
    MathFieldEditingController EH2Controller,
    MathFieldEditingController phi1Controller,
    MathFieldEditingController phi2Controller) {
  if (numofcomponents == 1 ||
      (getDouble(EH1Controller) == 0) ||
      (getDouble(EH2Controller) == 0)) {
    return '\\textbf{Reason: }\\text{The single component EM Wave equation is linearly polarized.}';
  }

  double phi1 = 0;
  double phi2 = 0;

  if (!phi1Controller.isEmpty) {
    if (isDegree) {
      phi1 = getDouble(phi1Controller);
    } else {
      phi1 = convertradiantodegree(phi1Controller);
    }
  }
  if (!phi2Controller.isEmpty) {
    if (isDegree) {
      phi2 = getDouble(phi2Controller);
    } else {
      phi2 = convertradiantodegree(phi2Controller);
    }
  }
  double absolutePhaseDiff = (phi1 - phi2).abs();

  if (absolutePhaseDiff == 0) {
    //Linear
    if (isDegree) {
      return '\\textbf{Reason: }\\text{The phase difference between the two components is $absolutePhaseDiff degrees.}';
    } else {
      return '\\textbf{Reason: }\\text{The phase difference between the two components is $absolutePhaseDiff radians.}';
    }
  }

  if (absolutePhaseDiff == 180) {
    //Linear
    if (isDegree) {
      return '\\textbf{Reason: }\\text{The phase difference between the two components is $absolutePhaseDiff degrees.}';
    } else {
      return '\\textbf{Reason: }\\text{The phase difference between the two components is } \\pi \\text{ radians.}';
    }
  }

  if ((absolutePhaseDiff == 90) &&
      (getDouble(EH1Controller) == getDouble(EH2Controller))) {
    //Circular
    if (isDegree) {
      return '\\textbf{Reason: }\\text{The phase difference between the two components is $absolutePhaseDiff degrees and the magnitudes of the two components are equal.}';
    } else {
      return '\\textbf{Reason: }\\text{The phase difference between the two components is } \\frac{\\pi}{2} \\text{ radians and the magnitudes of the two components are equal.}';
    }
  }
  //Elliptical
  return "\\textbf{Reason: }\\text{This EM Wave equation does not fit in the categories of linear or circular polarization.}";
}
