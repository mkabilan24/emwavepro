import 'dart:math';
import 'package:math_keyboard/math_keyboard.dart';

bool onchange = false;

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

//
//
MathFieldEditingController electricabsoluteE0 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH0 = MathFieldEditingController();
MathFieldEditingController phaseangle = MathFieldEditingController();

//
//Skin Depth
MathFieldEditingController skindepth = MathFieldEditingController();

//Phase Velocity
MathFieldEditingController phasevelocity = MathFieldEditingController();

//Wavelength
MathFieldEditingController wavelength = MathFieldEditingController();