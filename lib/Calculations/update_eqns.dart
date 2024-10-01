import 'package:math_keyboard/math_keyboard.dart';

bool isMathFieldEmpty(MathFieldEditingController controller) {
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

    E_Time_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${isMathFieldEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${isMathFieldEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    E_Phasor_Domain_Equation = '\\vec{E} =  $a_E_Field_Propagation ${isMathFieldEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${isMathFieldEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    H_Time_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${isMathFieldEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t $sign k$wavePropagationAxis + ${isMathFieldEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
    H_Phasor_Domain_Equation = '\\vec{H} =  $a_H_Field_Propagation ${isMathFieldEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${isMathFieldEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{${sign}jk$wavePropagationAxis}';

    if (a_k_Wave_Propagation == 'Error!') {
      message = "The directions of E-Field and H-Field cannot be on the same axis,\n as they have to be perpendicular to each other to form an EM Wave.\n";
    }

    return [message, E_Time_Domain_Equation, E_Phasor_Domain_Equation, H_Time_Domain_Equation, H_Phasor_Domain_Equation];
  }

//2 Component Equations
List update2CompEqns (String component, String a_E_Field_Propagation, String a_H_Field_Propagation, String a_k_Wave_Propagation, MathFieldEditingController _E0, MathFieldEditingController _H0, MathFieldEditingController _phi, String E0, String H0, String phi) {

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

    E_Time_Domain_Equation = '$a_E_Field_Propagation ${isMathFieldEmpty(_E0) ? '|E_{0${a_E_Field_Propagation[a_E_Field_Propagation.length-1]}}|' : _E0.currentEditingValue()}\\cos(\\omega t $sign {k}$wavePropagationAxis + ${isMathFieldEmpty(_phi) ? '\\phi_${a_E_Field_Propagation[a_E_Field_Propagation.length-1]}' : _phi.currentEditingValue()})';
    E_Phasor_Domain_Equation = '$a_E_Field_Propagation ${isMathFieldEmpty(_E0) ? '|E_{0${a_E_Field_Propagation[a_E_Field_Propagation.length-1]}}|' : _E0.currentEditingValue()}\\angle${isMathFieldEmpty(_phi) ? '\\phi_${a_E_Field_Propagation[a_E_Field_Propagation.length-1]}' : _phi.currentEditingValue()} e^{${sign}j{k}$wavePropagationAxis}';

    H_Time_Domain_Equation = '$a_H_Field_Propagation ${isMathFieldEmpty(_H0) ? '|H_{0${a_H_Field_Propagation[a_H_Field_Propagation.length-1]}}|' : _H0.currentEditingValue()}\\cos(\\omega t $sign {k}$wavePropagationAxis + ${isMathFieldEmpty(_phi) ? '\\phi_${a_H_Field_Propagation[a_H_Field_Propagation.length-1]}' : _phi.currentEditingValue()})';
    H_Phasor_Domain_Equation = '$a_H_Field_Propagation ${isMathFieldEmpty(_H0) ? '|H_{0${a_H_Field_Propagation[a_H_Field_Propagation.length-1]}}|' : _H0.currentEditingValue()}\\angle${isMathFieldEmpty(_phi) ? '\\phi_${a_H_Field_Propagation[a_H_Field_Propagation.length-1]}' : _phi.currentEditingValue()} e^{${sign}j{k}$wavePropagationAxis}';

    if (a_k_Wave_Propagation == 'Error!') {
      message = "The directions of E-Field and H-Field cannot be on the same axis,\n as they have to be perpendicular to each other to form an EM Wave.\n";
    }
    return [message, E_Time_Domain_Equation, E_Phasor_Domain_Equation, H_Time_Domain_Equation, H_Phasor_Domain_Equation];
  }

String determinepolarisation(MathFieldEditingController EH01, MathFieldEditingController EH02, MathFieldEditingController phi1, MathFieldEditingController phi2) {
  double EH01_value = double.parse(EH01.currentEditingValue());
  double EH02_value = double.parse(EH01.currentEditingValue());

  double phi1_value = double.parse(phi1.currentEditingValue());
  double phi2_value = double.parse(phi2.currentEditingValue());

  if ((EH01_value == 0) || (EH02_value == 0)) {
    return "Linear";
  }
  double absolute_phase_diff = (phi1_value - phi2_value).abs();
  if ((absolute_phase_diff == 0) || (absolute_phase_diff == 180)) {
    return "Linear";
  }
  if ((absolute_phase_diff == 90) && (EH01_value == EH02_value)) {
    return "Circular";
  }
  return "Elliptical";
}