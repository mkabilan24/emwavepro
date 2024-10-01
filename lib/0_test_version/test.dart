import 'package:emwavepro/0_test_version/0_globalvariables.dart';
import 'package:emwavepro/0_test_version/1_MathFieldEditingFunctions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:emwavepro/0_test_version/14_DirectionVectors.dart';
import 'package:emwavepro/0_test_version/ErrorSnackBar.dart';

class EMFieldEquationsWidget extends StatefulWidget {
  @override
  _EMFieldEquationsWidgetState createState() => _EMFieldEquationsWidgetState();
}

class _EMFieldEquationsWidgetState extends State<EMFieldEquationsWidget> {
  SnackbarController snackbarController = SnackbarController();

  final MathFieldEditingController _E0Controller = MathFieldEditingController();
  final MathFieldEditingController _H0Controller = MathFieldEditingController();
  final MathFieldEditingController _phiController = MathFieldEditingController();
  final MathFieldEditingController _angularfreq = MathFieldEditingController();
  final MathFieldEditingController _wavenumber = MathFieldEditingController();

  // Default directions of EM Wave
  String a_E_Field_Propagation = '+\\vec{a}_x';
  String a_H_Field_Propagation = '+\\vec{a}_y';
  String a_k_Wave_Propagation = '+\\vec{a}_z';

  String _getSign(String direction) {
    return direction.startsWith('+') ? '-' : '+';
  }

  String _getWavePropagationAxis(String direction) {
    return direction[direction.length - 1];
  }

  String _getPhiStringTimeDomainForm() {
    String phiSign; // Determine the sign for the phase angle
    double? phiNumeric = double.tryParse(_phiController.currentEditingValue());
    if (phiNumeric == null) {
      phiSign = '+ \\phi'; // Default to showing φ if parsing fails
    } else {
      phiSign = phiNumeric >= 0 ? '+ $phiNumeric' : '- ${phiNumeric.abs()}';
    }
    return phiSign;
  }

  String _getPhiStringPhasorDomainForm() {
    String phiSign; // Determine the sign for the phase angle
    double? phiNumeric = double.tryParse(_phiController.currentEditingValue());
    if (phiNumeric == null) {
      phiSign = '\\phi'; // Default to showing φ if parsing fails
    } else {
      phiSign = phiNumeric >= 0 ? '$phiNumeric' : '- ${phiNumeric.abs()}';
    }
    return phiSign;
  }

  String _getabsoluteValue (MathFieldEditingController controller, String variable) {
    double? controllerNumeric = double.tryParse(controller.currentEditingValue());
    if (controllerNumeric == null) {
      return variable;
    } else {
      return controllerNumeric.abs().toString();
    }
  }

  String _generateETimeDomainEquation() {
    String wavepropagationsign = _getSign(a_k_Wave_Propagation);
    String wavePropagationAxis = _getWavePropagationAxis(a_k_Wave_Propagation);

    return '\\vec{E} = $a_E_Field_Propagation ${_getabsoluteValue(_E0Controller, '|E_{0}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : _angularfreq.currentEditingValue()} t $wavepropagationsign ${(_wavenumber.isEmpty) ? 'k' : _wavenumber.currentEditingValue()}$wavePropagationAxis ${_getPhiStringTimeDomainForm()})';
  }

  String _generateEPhasorDomainEquation() {
    String sign = _getSign(a_k_Wave_Propagation);
    String wavePropagationAxis = _getWavePropagationAxis(a_k_Wave_Propagation);

    return '\\vec{E} = $a_E_Field_Propagation ${_getabsoluteValue(_E0Controller, '|E_{0}|')}\\angle${_getPhiStringPhasorDomainForm()} e^{$sign j${(_wavenumber.isEmpty) ? 'k' : _wavenumber.currentEditingValue()}$wavePropagationAxis}';
  }

  String _generateHTimeDomainEquation() {
    String sign = _getSign(a_k_Wave_Propagation);
    String wavePropagationAxis = _getWavePropagationAxis(a_k_Wave_Propagation);

    return '\\vec{H} = $a_H_Field_Propagation ${_getabsoluteValue(_H0Controller, '|H_{0}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : _angularfreq.currentEditingValue()} t $sign ${(_wavenumber.isEmpty) ? 'k' : _wavenumber.currentEditingValue()}$wavePropagationAxis ${_getPhiStringTimeDomainForm()})';
  }

  String _generateHPhasorDomainEquation() {
    String sign = _getSign(a_k_Wave_Propagation);
    String wavePropagationAxis = _getWavePropagationAxis(a_k_Wave_Propagation);

    return '\\vec{H} = $a_H_Field_Propagation ${_getabsoluteValue(_H0Controller, '|H_{0}|')}\\angle${_getPhiStringPhasorDomainForm()} e^{$sign j${(_wavenumber.isEmpty) ? 'k' : _wavenumber.currentEditingValue()}$wavePropagationAxis}';
  }

  void _validateAngularFrequency(BuildContext context, MathFieldEditingController controller) {
    double? angularFrequency = double.tryParse(controller.currentEditingValue());
    if (angularFrequency != null && angularFrequency < 0) {
      snackbarController.showTemporaryErrorSnackBar(context, "Angular Frequency (ω) must be positive!");
      controller.clear();
    } else if (angularFrequency == 0) {
      snackbarController.showTemporaryErrorSnackBar(context, "Angular Frequency (ω) must be non-zero!");
      controller.clear();
    }
  }

  void _validateWavenumber(BuildContext context, MathFieldEditingController controller) {
    double? wavenumber = double.tryParse(controller.currentEditingValue());
    if (wavenumber != null && wavenumber < 0) {
      snackbarController.showTemporaryErrorSnackBar(context, "Wavenumber (k) must be positive!");
      controller.clear();
    } else if (wavenumber == 0) {
      snackbarController.showTemporaryErrorSnackBar(context, "Wavenumber (k) must be non-zero!");
      controller.clear();
    }
  }

  void _validateWaveVectors() {
    bool isvalid = validateWaveVectors(a_E_Field_Propagation, a_H_Field_Propagation, a_k_Wave_Propagation);
    if (!isvalid) {
      snackbarController.showPermanentErrorSnackBar(context, "Direction Vectors are Invalid!");
    } else {
      snackbarController.hideErrorSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EM Wave Equations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Fields
            const Text('Inputs'),
            MathField(
              controller: _E0Controller,
              decoration: const InputDecoration(labelText: 'Amplitude of E-Field, E₀'),
              onChanged: (value) => setState(() {}),
            ),
            MathField(
              controller: _H0Controller,
              decoration: const InputDecoration(labelText: 'Amplitude of H-Field, H₀'),
              onChanged: (value) => setState(() {}),
            ),
            MathField(
              controller: _phiController,
              decoration: const InputDecoration(labelText: 'Phase angle, φ'),
              onChanged: (value) => setState(() {}),
            ),
            MathField(
              controller: _angularfreq,
              decoration: const InputDecoration(labelText: 'Angular Frequency, ω'),
              onChanged: (value) {
                _validateAngularFrequency(context, _angularfreq);
                setState(() {});
              },
            ),
            MathField(
              controller: _wavenumber,
              decoration: const InputDecoration(labelText: 'Wavenumber, k'),
              onChanged: (value) {
                _validateWavenumber(context, _wavenumber);
                setState(() {});
              },
            ),
            Row(
              children: [
                Math.tex('\\text{E-Field propagation: }\\vec{a}_{E}=', textStyle: const TextStyle(fontSize: 18),),
                const SizedBox(width: 10),
                Expanded(
                  child: MathDropdown(
                    initialValue: a_E_Field_Propagation,
                    options: vect_options,
                    onChanged: (newValue) {
                      setState(() {
                        a_E_Field_Propagation = newValue;
                        _validateWaveVectors();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Math.tex('\\text{H-Field propagation: }\\vec{a}_{H}=', textStyle: const TextStyle(fontSize: 18),),
                const SizedBox(width: 10),
                Expanded(
                  child: MathDropdown(
                    initialValue: a_H_Field_Propagation,
                    options: vect_options,
                    onChanged: (newValue) {
                      setState(() {
                        a_H_Field_Propagation = newValue;
                        _validateWaveVectors();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Math.tex('\\text{Wave propagation: }\\vec{a}_{k}=', textStyle: const TextStyle(fontSize: 18),),
                const SizedBox(width: 10),
                Expanded(
                  child: MathDropdown(
                    initialValue: a_k_Wave_Propagation,
                    options: vect_options,
                    onChanged: (newValue) {
                      setState(() {
                        a_k_Wave_Propagation = newValue;
                        _validateWaveVectors();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Display Equations
            const Text('Time Domain Equations:'),
            Math.tex(_generateETimeDomainEquation(), textStyle: const TextStyle(fontSize: 20)),
            Math.tex(_generateHTimeDomainEquation(), textStyle: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Text('Phasor Domain Equations:'),
            Math.tex(_generateEPhasorDomainEquation(), textStyle: const TextStyle(fontSize: 20)),
            Math.tex(_generateHPhasorDomainEquation(), textStyle: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: EMFieldEquationsWidget()));
}
