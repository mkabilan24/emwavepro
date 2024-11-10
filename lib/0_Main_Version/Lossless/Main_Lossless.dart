import 'dart:math';
import 'package:emwavepro/0_Main_Version/Lossless/9_Lossless_Equations_Components.dart';
import 'package:emwavepro/0_Main_Version/Shared/WavePolarisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/0_Main_Version/Lossless/Lossless_WaveEM_Properties.dart';
import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Lossless/Lossless_Medium_Properties.dart';

import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Shared/ErrorSnackBar.dart';
import 'package:emwavepro/0_Main_Version/Shared/GraphicalPlot.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';

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
  double labeloffset = 0.0;

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

  String _getabsoluteValue(
      MathFieldEditingController controller, String variable) {
    double? controllerNumeric =
        double.tryParse(controller.currentEditingValue());
    if (controllerNumeric == null) {
      return variable;
    } else {
      return controllerNumeric.abs().toString();
    }
  }

  String _generateETimeDomainEquation() {
    String ETimeDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${_getabsoluteValue(_E1Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : _angularfreq.currentEditingValue()} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi1Controller)})';
    if (numofcomponents == 2) {
      ETimeDomainEquation += '$a_E_Field_Propagation2 ${_getabsoluteValue(_E2Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation2)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : _angularfreq.currentEditingValue()} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi2Controller)})';
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
    String HTimeDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${_getabsoluteValue(_H1Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : _angularfreq.currentEditingValue()} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi1Controller)})';
    if (numofcomponents == 2) {
      HTimeDomainEquation += '$a_H_Field_Propagation2 ${_getabsoluteValue(_H2Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation2)}}|')}\\cos(${(_angularfreq.isEmpty) ? '\\omega' : _angularfreq.currentEditingValue()} t ${_getSign(a_k_Wave_Propagation)} ${(_wavenumber.isEmpty) ? 'k' : displayexpression(_wavenumber)}${_getWavePropagationAxis(a_k_Wave_Propagation)} ${_getPhiStringTimeDomainForm(_phi2Controller)})';
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
                          print("EM Wave Generated!");
                          print("E1: ${_E1Controller.currentEditingValue()}");
                          print("H1: ${_H1Controller.currentEditingValue()}");
                          print("Phi1: ${_phi1Controller.currentEditingValue()}");

                          print("E2: ${_E2Controller.currentEditingValue()}");
                          print("H2: ${_H2Controller.currentEditingValue()}");
                          print("Phi2: ${_phi2Controller.currentEditingValue()}");

                          print("E-Field Propagation 1: $a_E_Field_Propagation1");
                          print("E-Field Propagation 2: $a_E_Field_Propagation2");

                          print("H-Field Propagation 1: $a_H_Field_Propagation1");
                          print("H-Field Propagation 2: $a_H_Field_Propagation2");

                          print("Wave Propagation: $a_k_Wave_Propagation");


                          print("Angular Frequency: ${_angularfreq.currentEditingValue()}");
                          print("Wavenumber: ${_wavenumber.currentEditingValue()}");

                        },
                        child: const Text('Generare EM Wave'),
                      ),
                      const SizedBox(width: 20), // Add space between buttons
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            clearAllFields();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 122, 112), // Background color
                          foregroundColor: Colors.black, // Font color
                        ),
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Display Equations
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0), // You can adjust the padding as needed
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Time Domain Equations:'),
                            Math.tex(_generateETimeDomainEquation(),
                                textStyle: const TextStyle(fontSize: 20)),
                            Math.tex(_generateHTimeDomainEquation(),
                                textStyle: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 20),
                            const Text('Phasor Domain Equations:'),
                            Math.tex(_generateEPhasorDomainEquation(),
                                textStyle: const TextStyle(fontSize: 20)),
                            Math.tex(_generateHPhasorDomainEquation(),
                                textStyle: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                  ),
                  const SizedBox(height: 20),
                  if (numofcomponents ==2) Text("Wave Polarization: ${determinepolarisation(_E1Controller, _E2Controller, _phi1Controller, _phi2Controller)}"),
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
                              eFieldMagnitude1: _E1Controller.isEmpty ? 0 : scaleNumber(getDouble(_E1Controller), 50, 100),
                              hFieldMagnitude1: _H1Controller.isEmpty ? 0 : scaleNumber(getDouble(_H1Controller), 50, 100),

                              eFieldMagnitude2: (numofcomponents == 2) ? (_E2Controller.isEmpty ? 0 : scaleNumber(getDouble(_E2Controller), 50, 100)) : 0,
                              hFieldMagnitude2: (numofcomponents == 2) ? (_H2Controller.isEmpty ? 0 : scaleNumber(getDouble(_H2Controller), 50, 100)) : 0,

                              waveNumber: _wavenumber.isEmpty ? 0 : scaleNumber(convertMathExpressionToDouble(_wavenumber), 0, 5),
                              phasorAngle1: _phi1Controller.isEmpty ? 0 : convertMathExpressionToDouble(_phi1Controller),
                              phasorAngle2: (numofcomponents == 2) ? (_phi2Controller.isEmpty ? 0 : convertMathExpressionToDouble(_phi2Controller)) : 0,

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




  // void _validateAngularFrequency(
  //     BuildContext context, MathFieldEditingController controller) {
  //   double? angularFrequency = convertMathExpressionToDouble(controller);
  //   if (angularFrequency < 0) {
  //     snackbarController.showTemporaryErrorSnackBar(
  //         context, "Angular Frequency (ω) must be positive!");
  //     controller.clear();
  //   } 
  // }

  // void _validateWavenumber(
  //     BuildContext context, MathFieldEditingController controller) {
  //   double? wavenumber = convertMathExpressionToDouble(controller);
  //   if (wavenumber < 0) {
  //     snackbarController.showTemporaryErrorSnackBar(
  //         context, "Wavenumber (k) must be positive!");
  //     controller.clear();
  //   }
  // }

  // void _validateWaveVectors(a_E_Field_Propagation, a_H_Field_Propagation, a_k_Wave_Propagation) {
  //   bool isvalid = validateRHRWaveVectors(a_E_Field_Propagation, a_H_Field_Propagation, a_k_Wave_Propagation);
  //   if (!isvalid) {
  //     snackbarController.showPermanentErrorSnackBar(
  //         context, "Direction Vectors are Invalid!");
  //   } else {
  //     snackbarController.hideErrorSnackBar();
  //   }
  // }