import 'dart:math';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/Complex_Math.dart';
import 'package:emwavepro/Shared/ErrorSnackBar.dart';

bool onchange = false;
SnackbarController snackbarController = SnackbarController();

//Given Field Component
String givenfield = 'E';

double pi = 3.14159265;
double permeabilityOfFreeSpace = (4 * pi * pow(10, -7));
double permittivityOfFreeSpace = ((1 / (36 * pi))) * pow(10, -9);

//Frequencies
MathFieldEditingController angularfreq = MathFieldEditingController();
MathFieldEditingController freq = MathFieldEditingController();

//Relative Permittivity and Permeability
MathFieldEditingController lossy_relativepermittivity =
    MathFieldEditingController();
MathFieldEditingController lossy_relativepermeability =
    MathFieldEditingController();

//Conductivity
//Lossless & FreeSpace, Conductivity = 0 && Lossy, Conductivity != 0
MathFieldEditingController lossy_conductivity = MathFieldEditingController();

//Loss Tangent
MathFieldEditingController losstangent = MathFieldEditingController();
bool isGoodConductor = false;

//Permittivity
//Lossy
MathFieldEditingController lossy_permittivity = MathFieldEditingController();
Complex complexpermittivity = Complex(0, 0);

//Permeability
MathFieldEditingController lossy_permeability = MathFieldEditingController();

//Equations
MathFieldEditingController electricabsoluteE1 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH1 = MathFieldEditingController();
MathFieldEditingController phaseangleE1 = MathFieldEditingController();
MathFieldEditingController phaseangleH1 = MathFieldEditingController();

// Default directions of EM Wave
String a_E_Field_Propagation1 = '+\\vec{a}_x';
String a_H_Field_Propagation1 = '+\\vec{a}_y';
String a_k_Wave_Propagation1 = '+\\vec{a}_z';

MathFieldEditingController electricabsoluteE2 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH2 = MathFieldEditingController();
MathFieldEditingController phaseangleE2 = MathFieldEditingController();
MathFieldEditingController phaseangleH2 = MathFieldEditingController();

// Default directions of EM Wave
String a_E_Field_Propagation2 = '+\\vec{a}_y';
String a_H_Field_Propagation2 = '-\\vec{a}_x';
String a_k_Wave_Propagation2 = '+\\vec{a}_z';

//Intrinsic impedance
//Lossy
List intrinsicimpedanceroots = [];
Complex complexintrinsicimpedance = Complex(0, 0);

//Wave Number
//Lossy
List waveNumberRoots = [];

//Propagation Constant
Complex propagation_constant = Complex(0, 0);

//Attenuation Constant
MathFieldEditingController lossy_attenuationconstant =
    MathFieldEditingController();

//Phase Constant
MathFieldEditingController lossy_phaseconstant = MathFieldEditingController();

//Phase Velocity
MathFieldEditingController lossy_phasevelocity = MathFieldEditingController();

//Wavelength
MathFieldEditingController lossy_wavelength = MathFieldEditingController();

//Skin Depth
MathFieldEditingController lossy_skindepth = MathFieldEditingController();

void lossy_clearAllFields() {
  angularfreq.clear();
  freq.clear();
  lossy_relativepermittivity.clear();
  lossy_relativepermeability.clear();
  lossy_conductivity.clear();
  isGoodConductor = false;
  lossy_permittivity.clear();
  lossy_permeability.clear();
  electricabsoluteE1.clear();
  magneticabsoluteH1.clear();
  phaseangleE1.clear();
  phaseangleH1.clear();
  electricabsoluteE2.clear();
  magneticabsoluteH2.clear();
  phaseangleE2.clear();
  phaseangleH2.clear();
  lossy_attenuationconstant.clear();
  lossy_phaseconstant.clear();
  lossy_phasevelocity.clear();
  lossy_wavelength.clear();
  lossy_skindepth.clear();
  losstangent.clear();
  intrinsicimpedanceroots.clear();
  waveNumberRoots.clear();
  complexintrinsicimpedance = Complex(0, 0);
  propagation_constant = Complex(0, 0);
  a_E_Field_Propagation1 = '+\\vec{a}_x';
  a_H_Field_Propagation1 = '+\\vec{a}_y';
  a_k_Wave_Propagation1 = '+\\vec{a}_z';

  a_E_Field_Propagation2 = '+\\vec{a}_y';
  a_H_Field_Propagation2 = '-\\vec{a}_x';
  a_k_Wave_Propagation2 = '+\\vec{a}_z';
}

// bool isfieldsempty() {
//   if (numofcomponents == 1) {
//     if (electricabsoluteE1.isEmpty || magneticabsoluteH1.isEmpty) {
//       return true;
//     }
//     else {
//       return false;
//     }
//   }
//   else if (numofcomponents == 2) {
//     if (electricabsoluteE1.isEmpty || magneticabsoluteH1.isEmpty
//     || electricabsoluteE2.isEmpty || magneticabsoluteH2.isEmpty) {
//       return true;
//     }
//     else {
//       return false;
//     }
//   }
//   else {
//     return true;
//   }
// }
