import 'dart:math';
import 'package:emwavepro/0_test_version/0_GlobalVariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/Calculations/complex_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

//1 Component in E or H Field Equations
//Only one component in E or H Field Equations
final MathFieldEditingController _E0 = MathFieldEditingController();
final MathFieldEditingController _H0 = MathFieldEditingController();
final MathFieldEditingController _phi = MathFieldEditingController();

//Default directions of EM Wave
String a_E_Field_Propagation = '+\\vec{a}_x';
String a_H_Field_Propagation = '+\\vec{a}_y';
String a_k_Wave_Propagation = '+\\vec{a}_z';

String sign = a_k_Wave_Propagation[0];
// if (sign == '+') {
//   sign = '-';
// }
// else {
//   sign = '+';
// }

String wavePropagationAxis = a_k_Wave_Propagation[a_k_Wave_Propagation.length - 1];


String E_Time_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${(_E0.isEmpty) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()})';
String E_Phasor_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${(_E0.isEmpty) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

String H_Time_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${(_H0.isEmpty) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()})';
String H_Phasor_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${(_H0.isEmpty) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

//1 Component Equation
List update1CompEqns (String a_E_Field_Propagation, String a_H_Field_Propagation, String a_k_Wave_Propagation, MathFieldEditingController _E0, MathFieldEditingController _H0, MathFieldEditingController _phi) {

    String E_Time_Domain_Equation = '';
    String E_Phasor_Domain_Equation = '';
    String H_Time_Domain_Equation = '';
    String H_Phasor_Domain_Equation = '';
    String message = '';

    String sign = a_k_Wave_Propagation[0];
    if (sign == '+') {
      sign = '-';
    }
    else {
      sign = '+';
    }

    String wavePropagationAxis = a_k_Wave_Propagation[a_k_Wave_Propagation.length - 1];

    E_Time_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${(_E0.isEmpty) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()})';
    E_Phasor_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${(_E0.isEmpty) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    H_Time_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${(_H0.isEmpty) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()})';
    H_Phasor_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${(_H0.isEmpty) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${(_phi.isEmpty) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    if (a_k_Wave_Propagation == 'Error!') {
      message = "The directions of E-Field and H-Field cannot be on the same axis,\n as they have to be perpendicular to each other to form an EM Wave.\n";
    }

    return [message, E_Time_Domain_Equation, E_Phasor_Domain_Equation, H_Time_Domain_Equation, H_Phasor_Domain_Equation];
  }

//Default Equations of EM Wave
// String E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 |E_{0}|\\cos(\\omega t - kz + \\phi)';
// String E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 |E_{0}|\\angle\\phi e^{-jkz}';

// String H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 |H_{0}|\\cos(\\omega t - kz + \\phi)';
// String H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_E_Field_Propagation_1 |H_{0}|\\angle\\phi e^{-jkz}';