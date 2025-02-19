import 'dart:math';
import 'package:emwavepro/Lossy/Lossy_Equations_Components.dart';
import 'package:emwavepro/Lossy/Lossy_WaveEM_Frequency_Properties.dart';
import 'package:emwavepro/Shared/Complex_Math.dart';
import 'package:emwavepro/Shared/Settings_GlobalVariables.dart';
import 'package:emwavepro/Shared/WavePolarisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Lossy/Lossy_WaveEM_Properties.dart';
import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/Lossy/Lossy_Medium_Properties.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/GraphicalPlot.dart';
import 'package:emwavepro/Shared/LaTexExpressionFormatter.dart';

class LossyEMFieldEquationsWidget extends StatefulWidget {
  @override
  _LossyEMFieldEquationsWidgetState createState() => _LossyEMFieldEquationsWidgetState();
}

class _LossyEMFieldEquationsWidgetState extends State<LossyEMFieldEquationsWidget> {

  //For Graphical Plot
  double angleX = pi;
  double angleY = 0;
  double zoom = 500.0;
  double labeloffset = 20.0;
  int numofcomponents = 1;

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
  final MathFieldEditingController _phiE1Controller = phaseangleE1;
  final MathFieldEditingController _phiH1Controller = phaseangleH1;

  final MathFieldEditingController _E2Controller = electricabsoluteE2;
  final MathFieldEditingController _H2Controller = magneticabsoluteH2;
  final MathFieldEditingController _phi2Controller = phaseangleE2;

  final MathFieldEditingController _angularfreq = angularfreq;
  final MathFieldEditingController _wavenumber = angularfreq;

  String ETimeDomainEquation = '';
  String EPhasorDomainEquation = '';
  String HTimeDomainEquation = '';
  String HPhasorDomainEquation = '';

  @override
  void initState() {
    super.initState();
    reseteqns();
  }

  double _convertdegreetoradian(MathFieldEditingController controller) {
    double degree = getDouble(controller);
    return degree * (pi / 180);
  }

  String _getSign(String direction) {
    return direction.startsWith('+') ? '-' : '+';
  }

  String _getWavePropagationAxis(String direction) {
    return direction[direction.length - 1];
  }

  String _getPhiStringDomainForm(MathFieldEditingController phiController) {
    String phiSign; // Determine the sign for the phase angle
    double? phiNumeric = double.tryParse(phiController.currentEditingValue());
    if (phiNumeric == null) {
      phiSign = '+ \\phi'; // Default to showing φ if parsing fails
    } else {
      phiSign = phiNumeric >= 0 ? '+ ${phiNumeric.toStringAsFixed(decimalPlaces)}' : '- ${phiNumeric.abs().toStringAsFixed(decimalPlaces)}';
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

  void get_lossy_H_eqn(MathFieldEditingController electricabsoluteE, MathFieldEditingController magneticabsoluteH) {

    ETimeDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${_getabsoluteValue(_E1Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} \\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation1)} ${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} ${_getWavePropagationAxis(a_k_Wave_Propagation1)} ${_getPhiStringDomainForm(_phiE1Controller)})';
    EPhasorDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${_getabsoluteValue(_E1Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} e^{-j (${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} z ${_getPhiStringDomainForm(_phiE1Controller)})}';

    //print(":::::::::Calculating H Equations");
    Complex complexmagneticabsoluteH = Complex.divide(Complex(getDouble(electricabsoluteE), 0), complexintrinsicimpedance);
    //print("Complex Magnetic H_y: ${complexmagneticabsoluteH.displayComplexExpression()}");
    updateDouble(magneticabsoluteH, complexmagneticabsoluteH.magnitude());
    double magneticabsoluteHArgument = complexmagneticabsoluteH.argument();
    //print("Absolute of Magnetic H_y: ${magneticabsoluteH.currentEditingValue()}");
    //print("Argument of Magnetic H_y: $magneticabsoluteHArgument");
    double phaseangleofH = getDouble(phaseangleE1) + magneticabsoluteHArgument;
    updateDouble(phaseangleH1, phaseangleofH);
    //print("Phase angle of Magnetic H_y: $phaseangleofH");
    HTimeDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${displayexpression(magneticabsoluteH)} e^{-${displayexpression(lossy_attenuationconstant)} z} \\cos(${displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation1)} ${displayexpression(lossy_phaseconstant)} ${_getWavePropagationAxis(a_k_Wave_Propagation1)} ${_getPhiStringDomainForm(_phiH1Controller)})';
    //print("HTimeDomainEquation: $HTimeDomainEquation");
    HPhasorDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${displayexpression(magneticabsoluteH)} e^{-${displayexpression(lossy_attenuationconstant)} z} e^{-j (${displayexpression(lossy_phaseconstant)} z ${_getPhiStringDomainForm(_phiH1Controller)})}';
    //print("HPhasorDomainEquation: $HPhasorDomainEquation");
  }

  void get_lossy_E_eqn(MathFieldEditingController electricabsoluteE, MathFieldEditingController magneticabsoluteH) {

    HTimeDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${_getabsoluteValue(_H1Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} \\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation1)} ${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} ${_getWavePropagationAxis(a_k_Wave_Propagation1)} ${_getPhiStringDomainForm(_phiE1Controller)})';
    HPhasorDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${_getabsoluteValue(_H1Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} e^{-j (${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} z ${_getPhiStringDomainForm(_phiE1Controller)})}';

    //print(":::::::::Calculating E Equations");
    Complex complexelectricabsoluteE = Complex.multiply(Complex(getDouble(magneticabsoluteH), 0), complexintrinsicimpedance);
    //print("Complex Magnetic E_x: ${complexelectricabsoluteE.displayComplexExpression()}");
    updateDouble(electricabsoluteE, complexelectricabsoluteE.magnitude());
    double electricabsoluteEArgument = complexelectricabsoluteE.argument();
    //print("Absolute of Electric E_x: ${electricabsoluteE.currentEditingValue()}");
    //print("Argument of Electric E_x: $electricabsoluteEArgument");
    double phaseangleofE = getDouble(phaseangleH1) + electricabsoluteEArgument;
    updateDouble(phaseangleE1, phaseangleofE);
    //print("Phase angle of Electric E_x: $phaseangleofE");
    ETimeDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${displayexpression(electricabsoluteE)} e^{-${displayexpression(lossy_attenuationconstant)} z} \\cos(${displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation1)} ${displayexpression(lossy_phaseconstant)} ${_getWavePropagationAxis(a_k_Wave_Propagation1)} ${_getPhiStringDomainForm(_phiE1Controller)}';
    //print("ETimeDomainEquation: $ETimeDomainEquation");
    EPhasorDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${displayexpression(electricabsoluteE)} e^{-${displayexpression(lossy_attenuationconstant)} z} e^{-j (${displayexpression(lossy_phaseconstant)} z ${_getPhiStringDomainForm(_phiE1Controller)})}';
    //print("EPhasorDomainEquation: $EPhasorDomainEquation");
  }

  void reseteqns() {
    ETimeDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${_getabsoluteValue(_E1Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} \\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation1)} ${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} ${_getWavePropagationAxis(a_k_Wave_Propagation1)} ${_getPhiStringDomainForm(_phiE1Controller)})';
    EPhasorDomainEquation = '\\vec{E} = $a_E_Field_Propagation1 ${_getabsoluteValue(_E1Controller, '|E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} e^{-j (${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} z ${_getPhiStringDomainForm(_phiE1Controller)})}';
    HTimeDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${_getabsoluteValue(_H1Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} \\cos(${(_angularfreq.isEmpty) ? '\\omega' : displayexpression(_angularfreq)} t ${_getSign(a_k_Wave_Propagation1)} ${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} ${_getWavePropagationAxis(a_k_Wave_Propagation1)} ${_getPhiStringDomainForm(_phiH1Controller)})';
    HPhasorDomainEquation = '\\vec{H} = $a_H_Field_Propagation1 ${_getabsoluteValue(_H1Controller, '|H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}}|')} e^{-${(lossy_attenuationconstant.isEmpty) ? '\\alpha' : displayexpression(lossy_attenuationconstant)} z} e^{-j (${(lossy_phaseconstant.isEmpty) ? '\\beta' : displayexpression(lossy_phaseconstant)} z ${_getPhiStringDomainForm(_phiH1Controller)})}';
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
                  LossyMediumDropdown(),
                  LossyWaveEMFreqDropdown(),
                  LossyWaveEMDropdown(),
                  LossyEquationComponentsDropdown(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (electricabsoluteE1.isEmpty && magneticabsoluteH1.isEmpty) {
                            print('Fields are empty');
                            snackbarController.showTemporaryErrorSnackBar(context, 'Please fill in all fields');
                            setState(() {});
                            return;
                          }
                          else {
                            setState(() {});
                            if (phaseangleE1.isEmpty) {
                              updateDouble(phaseangleE1, 0);
                            }
                            if (givenfield == "E") {
                              get_lossy_H_eqn(_E1Controller, _H1Controller);
                            }
                            if (givenfield == "H") {
                              get_lossy_E_eqn(_E1Controller, _H1Controller);
                            }
                          }
                        },
                        child: const Text('Generare EM Wave'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            clearAllFields();
                            snackbarController.hideErrorSnackBar();
                            reseteqns();
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
                              ETimeDomainEquation,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            Math.tex(
                              HTimeDomainEquation,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            const Divider(),
                            const Text(
                              'Phasor Domain Equations:',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Math.tex(
                              EPhasorDomainEquation,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            Math.tex(
                              HPhasorDomainEquation,
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
                      "Wave Polarization: ${determinepolarisation(_E1Controller, _E2Controller, _phiE1Controller, _phi2Controller)}",
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

                              waveNumber: _wavenumber.isEmpty ? 0 : scaleNumber(getDouble(_wavenumber), 0, 5),
                              phasorAngle1: _phiE1Controller.isEmpty ? 0 : _convertdegreetoradian(_phiE1Controller),
                              phasorAngle2: (numofcomponents == 2) ? (_phi2Controller.isEmpty ? 0 :  _convertdegreetoradian(_phi2Controller)) : 0,

                              eFieldDirection1: vectorFromLatex(a_E_Field_Propagation1),
                              hFieldDirection1: vectorFromLatex(a_H_Field_Propagation1),

                              eFieldDirection2: (numofcomponents == 2) ? vectorFromLatex(a_E_Field_Propagation2) : Point3D(0, 0, 0),
                              hFieldDirection2: (numofcomponents == 2) ? vectorFromLatex(a_H_Field_Propagation2) : Point3D(0, 0, 0),
                              wavePropagationDirection1: vectorFromLatex(a_k_Wave_Propagation1),
                              wavePropagationDirection2: vectorFromLatex(a_k_Wave_Propagation2),
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

void main_lossy() {
  runApp(MaterialApp(home: LossyEMFieldEquationsWidget()));
}