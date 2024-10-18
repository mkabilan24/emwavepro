import 'dart:math';
import 'package:emwavepro/Calculations/complex_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

double pi = 3.14159265;
double permeabilityOfFreeSpace = (4 * pi * pow(10, -7));
double permittivityOfFreeSpace = ((1/(36 * pi))) * pow(10, -9);
double conductivitymargin = 20; //This is the margin to compare with the loss tangent to determine if the medium is
                                //a good conductor or a bad conductor.

//Frequencies
MathFieldEditingController angularfreq = MathFieldEditingController();
MathFieldEditingController freq = MathFieldEditingController();

//Relative Permittivity and Permeability
MathFieldEditingController relativepermittivity = MathFieldEditingController();
MathFieldEditingController relativepermeability = MathFieldEditingController();

//Conductivity
//Lossless, Conductivity = 0 && Lossy, Conductivity != 0
MathFieldEditingController conductivity = MathFieldEditingController();

//Permittivity
//Lossless
MathFieldEditingController permittivity = MathFieldEditingController();
//Lossy
Complex complexpermittivity = Complex(0, 0);

//Permeability
MathFieldEditingController permeability = MathFieldEditingController();


MathFieldEditingController electricabsoluteE0 = MathFieldEditingController();
MathFieldEditingController magneticabsoluteH0 = MathFieldEditingController();

//Intrinsic impedance
//Lossless
MathFieldEditingController intrinsicimpedance = MathFieldEditingController();
//Lossy
List intrinsicimpedanceroots = [];
Complex complexintrinsicimpedance = Complex(0, 0);

//Wave Number
//Lossless
MathFieldEditingController wavenumber = MathFieldEditingController();
//Lossy
List waveNumberRoots = [];
Complex complexwavenumber_root1 = Complex(0, 0);
Complex complexwavenumber_root2 = Complex(0, 0);

MathFieldEditingController losstangent = MathFieldEditingController();

//Attenuation Constant
MathFieldEditingController attenuationconstant = MathFieldEditingController();

//Phase Constant
MathFieldEditingController phaseconstant = MathFieldEditingController();

//Skin Depth
MathFieldEditingController skindepth = MathFieldEditingController();

//Phase Velocity
MathFieldEditingController phasevelocity = MathFieldEditingController();

//Wavelength
MathFieldEditingController wavelength = MathFieldEditingController();