import 'dart:math';
import 'package:emwavepro/Lossless/9_Lossless_Equations_Components.dart';
import 'package:emwavepro/Shared/WavePolarisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Lossless/Lossless_WaveEM_Properties.dart';
import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/Lossless/Lossless_Medium_Properties.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/ErrorSnackBar.dart';
import 'package:emwavepro/Shared/GraphicalPlot.dart';
import 'package:emwavepro/Shared/LaTexExpressionFormatter.dart';

class EMFieldEquationsWidget extends StatefulWidget {
  @override
  _EMFieldEquationsWidgetState createState() => _EMFieldEquationsWidgetState();
}

class _EMFieldEquationsWidgetState extends State<EMFieldEquationsWidget> {
  SnackbarController snackbarController = SnackbarController();

  //For Graphical Plot
  double angleX = pi;
  double angleY = 0;
  double zoom = 500.0;
  double labeloffset = 5.0;

  void onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      angleX += details.focalPointDelta.dy * 0.01; // Rotate around X-axis
      angleY += details.focalPointDelta.dx * 0.01; // Rotate around Y-axis
      zoom = (zoom * details.scale).clamp(100.0, 800.0); // Zoom range
    });
  }

  Point3D vectorFromLatex(String latexVector) {
    final Map<String, Point3D> vectorMap = {
      '+\\vec{a}_x': Point3D(1, 0, 0),
      '-\\vec{a}_x': Point3D(-1, 0, 0),
      '+\\vec{a}_y': Point3D(0, 1, 0),
      '-\\vec{a}_y': Point3D(0, -1, 0),
      '+\\vec{a}_z': Point3D(0, 0, 1),
      '-\\vec{a}_z': Point3D(0, 0, -1),
    };
    // Default to (0, 0, 0) if not found
    return vectorMap[latexVector] ?? Point3D(0, 0, 0); 
  }

  final MathFieldEditingController _E1Controller = electricabsoluteE1;
  final MathFieldEditingController _H1Controller = magneticabsoluteH1;
  final MathFieldEditingController _phi1Controller = phaseangle1;

  final MathFieldEditingController _E2Controller = electricabsoluteE2;
  final MathFieldEditingController _H2Controller = magneticabsoluteH2;
  final MathFieldEditingController _phi2Controller = phaseangle2;

  final MathFieldEditingController _angularfreq = angularfreq;
  final MathFieldEditingController _wavenumber = lossless_wavenumber;

  double _convertdegreetoradian(MathFieldEditingController controller) {
    double degree = convertMathExpressionToDouble(controller);
    return degree * (pi / 180);
  }

  String _getSign(String direction) {
    return direction.startsWith('+') ? '-' : '+';
  }

  String _getWavePropagationAxis(String direction) {
    return direction[direction.length - 1];
  }

  String _getPhiStringTimeDomainForm(MathFieldEditingController phiController) {
    String phiSign; // Determine the sign for the phase angle
    double? phiNumeric = double.tryParse(phiController.currentEditingValue());
    if (phiNumeric == null) {
      phiSign = '+ \\phi'; // Default to showing φ if parsing fails
    } else {
      phiSign = phiNumeric >= 0 ? '+ $phiNumeric' : '- ${phiNumeric.abs()}';
    }
    return phiSign;
  }

  String _getPhiStringPhasorDomainForm(MathFieldEditingController phiController) {
    String phiSign; // Determine the sign for the phase angle
    double? phiNumeric = double.tryParse(phiController.currentEditingValue());
    if (phiNumeric == null) {
      phiSign = '\\phi'; // Default to showing φ if parsing fails
    } else {
      phiSign = phiNumeric >= 0 ? '$phiNumeric' : '- ${phiNumeric.abs()}';
    }
    return phiSign;
  }

  String _getabsoluteValue(MathFieldEditingController controller, String variable) {
    double? controllerNumeric = double.tryParse(displayexpression(controller));
    if (controllerNumeric == null) {
      return variable;
    } else {
      return controllerNumeric.abs().toString();
    }
  }

  String _generateETimeDomainEquation() {
    String ETimeDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${_getabsoluteValue(_E1Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi1Controller)})';
    if (numofcomponents == 2) {
      ETimeDomainEquation += '$a_E_Field_Propagation2 ${_getabsoluteValue(_E2Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation2)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi2Controller)})';
    }
    return ETimeDomainEquation;
  }

  String _generateEPhasorDomainEquation() {
    String EPhasorDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${_getabsoluteValue(_E1Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}}|')}\\angle${_getPhiStringPhasorDomainForm(_phi1Controller)} e^{${_getSign(a_k_Wave_Propagation)} j${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)}}';
    if (numofcomponents == 2) {
      EPhasorDomainEquation += '$a_E_Field_Propagation2 ${_getabsoluteValue(_E2Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation2)}}|')}\\angle${_getPhiStringPhasorDomainForm(_phi2Controller)} e^{${_getSign(a_k_Wave_Propagation)} j${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)}}';
    }
    return EPhasorDomainEquation;
  }

  String _generateHTimeDomainEquation() {
    String HTimeDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${_getabsoluteValue(_H1Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi1Controller)})';
    if (numofcomponents == 2) {
      HTimeDomainEquation += '$a_H_Field_Propagation2 ${_getabsoluteValue(_H2Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation2)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi2Controller)})';
    }
    return HTimeDomainEquation;
  }

  String _generateHPhasorDomainEquation() {
    String HPhasorDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${_getabsoluteValue(_H1Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}}|')}\\angle${_getPhiStringPhasorDomainForm(_phi1Controller)} e^{${_getSign(a_k_Wave_Propagation)} j${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)}}';
    if (numofcomponents == 2) {
      HPhasorDomainEquation += '$a_H_Field_Propagation2 ${_getabsoluteValue(_H2Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation2)}}|')}\\angle${_getPhiStringPhasorDomainForm(_phi2Controller)} e^{${_getSign(a_k_Wave_Propagation)} j${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)}}';
    }
    return HPhasorDomainEquation;
  }

  double scaleNumber(double number, double minScale, double maxScale) {
    if (number == 0) return minScale;
    
    // Calculate the logarithmic scale factor
    double logMin = -10; // Adjust this value based on the smallest expected input
    double logMax = 10;  // Adjust this value based on the largest expected input

    // Apply logarithmic scaling
    double logNumber = number.sign * (log(number.abs()) / ln10);

    // Normalize the logNumber to the range [0, 1]
    double normalized = (logNumber - logMin) / (logMax - logMin);

    // Scale to the desired range [minScale, maxScale]
    double scaledNumber = minScale + normalized * (maxScale - minScale);

    // Clamp the result to ensure it's within the range
    return scaledNumber.clamp(minScale, maxScale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  LosslessMediumDropdown(),
                  LosslessWaveEMDropdown(),
                  LosslessEquationComponentsDropdown(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text('Generare EM Wave'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            clearAllFields();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 122, 112),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                  // Display Equations
                  Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Time Domain Equations:',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Math.tex(
                              _generateETimeDomainEquation(),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            Math.tex(
                              _generateHTimeDomainEquation(),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            const Divider(),
                            const Text(
                              'Phasor Domain Equations:',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Math.tex(
                              _generateEPhasorDomainEquation(),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            Math.tex(
                              _generateHPhasorDomainEquation(),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: Colors.grey[300],
                    child: Text(
                      "Wave Polarization: ${determinepolarisation(_E1Controller, _E2Controller, _phi1Controller, _phi2Controller)}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                          onScaleUpdate: onScaleUpdate,
                          child: CustomPaint(
                            painter: Graph3DPainter(
                              angleX: angleX,
                              angleY: angleY,
                              zoom: zoom,
                              labeloffset: labeloffset,
                              eFieldMagnitude1: _E1Controller.isEmpty ? 0 : scaleNumber(getDouble(_E1Controller), 0, 100),
                              hFieldMagnitude1: _H1Controller.isEmpty ? 0 : scaleNumber(getDouble(_H1Controller), 0, 100),

                              eFieldMagnitude2: (numofcomponents == 2) ? (_E2Controller.isEmpty ? 0 : scaleNumber(getDouble(_E2Controller), 0, 100)) : 0,
                              hFieldMagnitude2: (numofcomponents == 2) ? (_H2Controller.isEmpty ? 0 : scaleNumber(getDouble(_H2Controller), 0, 100)) : 0,

                              waveNumber: _wavenumber.isEmpty ? 0 : scaleNumber(convertMathExpressionToDouble(_wavenumber), 0, 5),
                              phasorAngle1: _phi1Controller.isEmpty ? 0 : _convertdegreetoradian(_phi1Controller),
                              phasorAngle2: (numofcomponents == 2) ? (_phi2Controller.isEmpty ? 0 :  _convertdegreetoradian(_phi2Controller)) : 0,

                              eFieldDirection1: vectorFromLatex(a_E_Field_Propagation1),
                              hFieldDirection1: vectorFromLatex(a_H_Field_Propagation1),

                              eFieldDirection2: (numofcomponents == 2) ? vectorFromLatex(a_E_Field_Propagation2) : Point3D(0, 0, 0),
                              hFieldDirection2: (numofcomponents == 2) ? vectorFromLatex(a_H_Field_Propagation2) : Point3D(0, 0, 0),
                              wavePropagationDirection: vectorFromLatex(a_k_Wave_Propagation),
                            ),
                            size: Size.infinite,
                          )
                        ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main_lossless() {
  runApp(MaterialApp(home: EMFieldEquationsWidget()));
}