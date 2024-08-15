import 'package:math_keyboard/math_keyboard.dart';

bool _isMFControllerEmpty(MathFieldEditingController controller) {
    if (controller.currentEditingValue().contains('\\Box')) {
      return true;
    }
    return false;
  }

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

    E_Time_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    E_Phasor_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    H_Time_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    H_Phasor_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    if (a_k_Wave_Propagation == 'Error!') {
      message = "The directions of E-Field and H-Field cannot be on the same axis,\n as they have to be perpendicular to each other to form an EM Wave.";
    }

    return [message, E_Time_Domain_Equation, E_Phasor_Domain_Equation, H_Time_Domain_Equation, H_Phasor_Domain_Equation];
  }

//2 Component Equations
List update2_1CompEqns (String a_E_Field_Propagation, String a_H_Field_Propagation, String a_k_Wave_Propagation, MathFieldEditingController _E0, MathFieldEditingController _H0, MathFieldEditingController _phi, String E0, String H0, String phi) {

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

    E_Time_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${_isMFControllerEmpty(_E0) ? '|E_{0${a_E_Field_Propagation[a_E_Field_Propagation.length-1]}}|' : _E0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    E_Phasor_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    H_Time_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    H_Phasor_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    if (a_k_Wave_Propagation == 'Error!') {
      message = "The directions of E-Field and H-Field cannot be on the same axis,\n as they have to be perpendicular to each other to form an EM Wave.";
    }

    return [message, E_Time_Domain_Equation, E_Phasor_Domain_Equation, H_Time_Domain_Equation, H_Phasor_Domain_Equation];
  }

  //Default Equations of EM Wave
  String E_Time_Domain_Equation_1 = '\\vec{E} =  +\\vec{a}_x |E_{0}|\\cos(\\omega t - kz + \\phi)';
  String E_Phasor_Domain_Equation_1 = '\\vec{E} =  +\\vec{a}_x |E_{0}|\\angle\\phi e^{-jkz}';

  String H_Time_Domain_Equation_1 = '\\vec{H} =  +\\vec{a}_y |H_{0}|\\cos(\\omega t - kz + \\phi)';
  String H_Phasor_Domain_Equation_1 = '\\vec{H} =  +\\vec{a}_y |H_{0}|\\angle\\phi e^{-jkz}';