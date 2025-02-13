import 'dart:math';
import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/Shared/ErrorSnackBar.dart';
import 'package:math_keyboard/math_keyboard.dart';

bool onchange = false;
SnackbarController snackbarController = SnackbarController();

int numofcomponents = 1; //Number of components of the EM wave Equations

double pi = 3.14159265;
double permeabilityOfFreeSpace = (4 * pi * pow(10, -7));
double permittivityOfFreeSpace = ((1/(36 * pi))) * pow(10, -9);

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
String a_k_Wave_Propagation1 = '+\\vec{a}_z';

MathFieldEditingController electricabsoluteE2 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH2 = MathFieldEditingController();
MathFieldEditingController phaseangle2 = MathFieldEditingController();

// Default directions of EM Wave
String a_E_Field_Propagation2 = '+\\vec{a}_y';
String a_H_Field_Propagation2 = '-\\vec{a}_x';
String a_k_Wave_Propagation2 = '+\\vec{a}_z';


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
  a_k_Wave_Propagation1 = '+\\vec{a}_z';

  a_E_Field_Propagation2 = '+\\vec{a}_y';
  a_H_Field_Propagation2 = '-\\vec{a}_x';
  a_k_Wave_Propagation2 = '+\\vec{a}_z';
}

bool isfieldsempty() {
  if (numofcomponents == 1) {
    if (electricabsoluteE1.isEmpty || magneticabsoluteH1.isEmpty) {
      return true;
    }
    else {
      return false;
    }
  }
  else if (numofcomponents == 2) {
    if (electricabsoluteE1.isEmpty || magneticabsoluteH1.isEmpty
    || electricabsoluteE2.isEmpty || magneticabsoluteH2.isEmpty) {
      return true;
    }
    else {
      return false;
    }
  }
  else {
    return true;
  }
}

