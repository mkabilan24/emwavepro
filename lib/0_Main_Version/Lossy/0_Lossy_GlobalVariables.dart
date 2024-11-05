import 'dart:math';
import 'package:emwavepro/Archive/Calculations/complex_math.dart';
import 'package:flutter/material.dart';
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
MathFieldEditingController lossy_relativepermittivity = MathFieldEditingController();
MathFieldEditingController lossy_relativepermeability = MathFieldEditingController();

//Conductivity
//Lossless & FreeSpace, Conductivity = 0 && Lossy, Conductivity != 0
MathFieldEditingController lossy_conductivity = MathFieldEditingController();

//Permittivity
//Lossy
Complex complexpermittivity = Complex(0, 0);

//Permeability
MathFieldEditingController lossy_permeability = MathFieldEditingController();


MathFieldEditingController electricabsoluteE0 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH0 = MathFieldEditingController();

//Intrinsic impedance
//Lossy
List intrinsicimpedanceroots = [];
Complex complexintrinsicimpedance = Complex(0, 0);

//Wave Number
//Lossy
List waveNumberRoots = [];
Complex complexwavenumber_root1 = Complex(0, 0);
Complex complexwavenumber_root2 = Complex(0, 0);

//Attenuation Constant
MathFieldEditingController lossy_attenuationconstant = MathFieldEditingController();

//Phase Constant
MathFieldEditingController lossy_phaseconstant = MathFieldEditingController();


//
//
MathFieldEditingController losstangent = MathFieldEditingController();

//Skin Depth
MathFieldEditingController skindepth = MathFieldEditingController();

//Phase Velocity
MathFieldEditingController phasevelocity = MathFieldEditingController();

//Wavelength
MathFieldEditingController wavelength = MathFieldEditingController();