import 'package:emwavepro/main.dart';
import 'package:math_keyboard/math_keyboard.dart';

bool _isMFControllerEmpty(MathFieldEditingController controller) {
    if (controller.currentEditingValue().contains('\\Box')) {
      return true;
    }
    return false;
  }

void _update1CompEqns (String a_E_Field_Propagation_1, String a_H_Field_Propagation_1, String a_k_Wave_Propagation_1, MathFieldEditingController _E0, MathFieldEditingController _H0, MathFieldEditingController _phi) {
    
    //Wave Propagation on X-axis
    if (a_k_Wave_Propagation_1 == '+\\vec{a}_x') {
      E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t - kx + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jkx}';

      H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t - kx + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jkx}';
    }
    if (a_k_Wave_Propagation_1 == '-\\vec{a}_x') {
      E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t + kx + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jkx}';

      H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t + kx + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jkx}';
    }

    //Wave Propagation on Y-axis
    if (a_k_Wave_Propagation_1 == '+\\vec{a}_y') {
      E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t - ky + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jky}';

      H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t - ky + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jky}';
    }
    if (a_k_Wave_Propagation_1 == '-\\vec{a}_y') {
      E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t + ky + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jky}';

      H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t + ky + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jky}';
    }

    //Wave Propagation on Z-axis
    if (a_k_Wave_Propagation_1 == '+\\vec{a}_z') {
      E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t - kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jkz}';

      H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t - kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{-jkz}';
    }
    if (a_k_Wave_Propagation_1 == '-\\vec{a}_z') {
      E_Time_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\cos(\\omega t + kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      E_Phasor_Domain_Equation_1 = '\\vec{E} =  $a_E_Field_Propagation_1 ${_isMFControllerEmpty(_E0) ? '|E_{0}|' : _E0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jkz}';

      H_Time_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\cos(\\omega t + kz + ${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()})';
      H_Phasor_Domain_Equation_1 = '\\vec{H} =  $a_H_Field_Propagation_1 ${_isMFControllerEmpty(_H0) ? '|H_{0}|' : _H0.currentEditingValue()}\\angle${_isMFControllerEmpty(_phi) ? '\\phi' : _phi.currentEditingValue()} e^{+jkz}';
    }
  }