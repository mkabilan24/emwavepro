import 'dart:math';
import 'package:emwavepro/Shared/ErrorSnackBar.dart';
import 'package:math_keyboard/math_keyboard.dart';

bool onchange = false;
SnackbarController snackbarController = SnackbarController();
int numofcomponents = 1; //Number of components of the EM wave Equations

double pi = 3.14159265;
double permeabilityOfFreeSpace = (4 * pi * pow(10, -7));
double permittivityOfFreeSpace = ((1/(36 * pi))) * pow(10, -9);
double conductivitymargin = 20; //This is the margin to compare with the loss tangent to determine if the medium is
                                //a good conductor or a bad conductor.

//Frequencies
MathFieldEditingController angularfreq = MathFieldEditingController();
MathFieldEditingController freq = MathFieldEditingController();

//Relative Permittivity and Permeability
MathFieldEditingController lossless_relativepermittivity = MathFieldEditingController();
MathFieldEditingController lossless_relativepermeability = MathFieldEditingController();

//Conductivity
//Lossless & FreeSpace, Conductivity = 0 && Lossy, Conductivity != 0
MathFieldEditingController lossless_conductivity = MathFieldEditingController();

//Permittivity
//Lossless
MathFieldEditingController lossless_permittivity = MathFieldEditingController();

//Permeability
MathFieldEditingController lossless_permeability = MathFieldEditingController();

//Intrinsic impedance
//Lossless
MathFieldEditingController lossless_intrinsicimpedance = MathFieldEditingController();

//Wave Number
//Lossless
MathFieldEditingController lossless_wavenumber = MathFieldEditingController();

//Attenuation Constant
MathFieldEditingController lossless_attenuationconstant = MathFieldEditingController();

//Phase Constant
MathFieldEditingController lossless_phaseconstant = MathFieldEditingController();


//Equations
MathFieldEditingController electricabsoluteE1 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH1 = MathFieldEditingController();
MathFieldEditingController phaseangle1 = MathFieldEditingController();

// Default directions of EM Wave
String a_E_Field_Propagation1 = '+\\vec{a}_x';
String a_H_Field_Propagation1 = '+\\vec{a}_y';

MathFieldEditingController electricabsoluteE2 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH2 = MathFieldEditingController();
MathFieldEditingController phaseangle2 = MathFieldEditingController();

// Default directions of EM Wave
String a_E_Field_Propagation2 = '+\\vec{a}_y';
String a_H_Field_Propagation2 = '-\\vec{a}_x';

//Resultant Direction of Wave Propagation
String a_k_Wave_Propagation = '+\\vec{a}_z';

void clearAllFields() {
  lossless_relativepermittivity.clear();
  lossless_relativepermeability.clear();
  lossless_conductivity.clear();
  lossless_permittivity.clear();
  lossless_permeability.clear();
  lossless_intrinsicimpedance.clear();
  lossless_wavenumber.clear();
  lossless_attenuationconstant.clear();
  lossless_phaseconstant.clear();

  electricabsoluteE1.clear();
  magneticabsoluteH1.clear();
  phaseangle1.clear();

  electricabsoluteE2.clear();
  magneticabsoluteH2.clear();
  phaseangle2.clear();
  
  freq.clear();
  angularfreq.clear();

  a_E_Field_Propagation1 = '+\\vec{a}_x';
  a_H_Field_Propagation1 = '+\\vec{a}_y';

  a_E_Field_Propagation2 = '+\\vec{a}_y';
  a_H_Field_Propagation2 = '-\\vec{a}_x';

  a_k_Wave_Propagation = '+\\vec{a}_z';
}



