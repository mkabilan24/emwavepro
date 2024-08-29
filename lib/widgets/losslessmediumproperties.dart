import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';

class LosslessMediumPropertiesWidget extends StatefulWidget {
  @override
  _LosslessMediumPropertiesWidgetState createState() => _LosslessMediumPropertiesWidgetState();
}

class _LosslessMediumPropertiesWidgetState extends State<LosslessMediumPropertiesWidget> {
  MathFieldEditingController _angularfreq = MathFieldEditingController();
  MathFieldEditingController _freq = MathFieldEditingController();
  MathFieldEditingController _realtivepermittivity = MathFieldEditingController();
  MathFieldEditingController _relativepermeability = MathFieldEditingController();
  MathFieldEditingController _wavenumber = MathFieldEditingController();
  MathFieldEditingController _intrinsicimpedence = MathFieldEditingController();

  bool _isUpdating = false;
  double pi = 3.14159265;

  void calc_angular_freq() {
    if (_isUpdating) return;

    _isUpdating = true;

    // LaTeX equation: ω = 2πf
    if (_freq.isEmpty) {
      // Clear Input Field including '0'
      _angularfreq.clear();
      _isUpdating = false;
      return;
    }

    double freqValue = double.parse(_freq.currentEditingValue());
    double angular_freq = 2 * pi * freqValue;

    // Only expressions can be updated to the input fields,
    // hence the double value has to be String and Parsed
    final expression = Parser().parse(angular_freq.toString());
    _angularfreq.updateValue(expression);
    print("The value of Angular Frequency is: $angular_freq");

    _isUpdating = false;
  }

  void calc_freq() {
    if (_isUpdating) return;

    _isUpdating = true;

    // LaTeX equation: f = ω/2π
    if (_angularfreq.isEmpty) {
      // Clear Input Field including '0'
      _freq.clear();
      _isUpdating = false;
      return;
    }

    double angularfreqValue = double.parse(_angularfreq.currentEditingValue());
    double freqValue= angularfreqValue / (2 * pi);

    // Only expressions can be updated to the input fields,
    // hence the double value has to be String and Parsed
    final expression = Parser().parse(freqValue.toString());
    _freq.updateValue(expression);
    print("The value of Frequency is: $freqValue");

    _isUpdating = false;
  }

  void calc_wave_number() {
    if (_isUpdating) return;

    _isUpdating = true;

    // LaTeX equation: k = ??
    if (_angularfreq.isEmpty || _relativepermeability.isEmpty || _realtivepermittivity.isEmpty) {
      // Clear Input Field including '0'
      _wavenumber.clear();
      _isUpdating = false;
      return;
    }

    if (!_angularfreq.isEmpty && !_relativepermeability.isEmpty && !_realtivepermittivity.isEmpty) {
      double angularfreqValue = double.parse(_angularfreq.currentEditingValue());
      double realtivepermittivityValue = double.parse(_realtivepermittivity.currentEditingValue());
      double relativepermeabilityValue = double.parse(_relativepermeability.currentEditingValue());

      double wavenumberValue = sqrt(pow(angularfreqValue, 2) * realtivepermittivityValue * ((1 * pow(10, -9))/(36*pi)) * relativepermeabilityValue * (4 * pi * pow(10, -7)));

      final expression = Parser().parse(wavenumberValue.toString());
      _wavenumber.updateValue(expression);
      print("The value of Wave Number is: $wavenumberValue");
    }

    _isUpdating = false;
  }

  void calc_intrinsic_impedence() {
    if (_isUpdating) return;

    _isUpdating = true;

    if (!_relativepermeability.isEmpty && !_realtivepermittivity.isEmpty) {
      double realtivepermittivityValue = double.parse(_realtivepermittivity.currentEditingValue());
      double relativepermeabilityValue = double.parse(_relativepermeability.currentEditingValue());

      double intrinsicimpedence = sqrt(relativepermeabilityValue/realtivepermittivityValue) * 120 * pi;

      final expression = Parser().parse(intrinsicimpedence.toString());
      _intrinsicimpedence.updateValue(expression);
      print("The value of Intrinsic Impedence is: $intrinsicimpedence");
    }
    else {
      _intrinsicimpedence.clear();
    }

    _isUpdating = false;
  }

  bool _isMFControllerEmpty(MathFieldEditingController controller) {
    if (controller.currentEditingValue().contains('\\Box')) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Lossless Medium Properties",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8), // Adjust padding as needed
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400]!, // Border color
              width: 1.0, // Border width
            ),
            borderRadius: BorderRadius.circular(8), // Optional: Border radius
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width, // Maximum width constraint
              ), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Math.tex('\\text{Conductivity, }\\sigma = 0',
                      textStyle: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex(
                        '\\text{Frequency, }f = ',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 100, // Set the fixed width
                        height: 40, // Set the fixed height
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border if needed
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100, // Ensure minimum width matches container width
                            ),
                            child: IntrinsicWidth(
                              child: MathField(
                                  controller: _freq,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {
                                      calc_angular_freq();
                                      calc_wave_number();
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex(
                        '\\text{Angular Frequency, }\\omega = 2\\pi f = ',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 100, // Set the fixed width
                        height: 40, // Set the fixed height
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border if needed
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100, // Ensure minimum width matches container width
                            ),
                            child: IntrinsicWidth(
                              child: MathField(
                                  controller: _angularfreq,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {
                                      calc_freq();
                                      calc_wave_number();
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex(
                        '\\text{Permittivity, }\\varepsilon = \\varepsilon_{r}\\varepsilon_{0} = ',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 100, // Set the fixed width
                        height: 40, // Set the fixed height
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border if needed
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100, // Ensure minimum width matches container width
                            ),
                            child: IntrinsicWidth(
                              child: MathField(
                                  controller: _realtivepermittivity,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    calc_wave_number();
                                    calc_intrinsic_impedence();
                                    setState(() {}); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Math.tex(
                        '\\varepsilon_{0}',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex(
                        '\\text{Permeability, }\\mu = \\mu_{r}\\mu_{0} = ',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 100, // Set the fixed width
                        height: 40, // Set the fixed height
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border if needed
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100, // Ensure minimum width matches container width
                            ),
                            child: IntrinsicWidth(
                              child: MathField(
                                  controller: _relativepermeability,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    calc_wave_number();
                                    calc_intrinsic_impedence();
                                    setState(() {}); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Math.tex(
                        '\\mu_{0}',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ]
                  ),
                  const SizedBox(height: 15),
                  Math.tex(
                    '\\text{Ampere\'s Law, }\\nabla \\times H = j \\omega \\varepsilon E',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex(
                        '\\text{Wave Number, }k = \\sqrt{\\omega^{2}\\mu\\varepsilon} = ',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 100, // Set the fixed width
                        height: 40, // Set the fixed height
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border if needed
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100, // Ensure minimum width matches container width
                            ),
                            child: IntrinsicWidth(
                              child: MathField(
                                  controller: _wavenumber,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {}); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Math.tex(
                    '\\text{Attenuation Constant, } \\alpha = 0',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex(
                        '\\text{Phase Constant, } \\beta = k = ',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 100, // Set the fixed width
                        height: 40, // Set the fixed height
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border if needed
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100, // Ensure minimum width matches container width
                            ),
                            child: IntrinsicWidth(
                              child: MathField(
                                  controller: _wavenumber,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {}); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Math.tex(
                    '\\text{Intrinsic Impedance, }',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex(' \\eta = \\sqrt{\\frac{\\mu}{\\varepsilon}} = \\sqrt{\\frac{\\mu_{r}}{\\varepsilon_{r}}} \\times 120\\pi = ',
                        textStyle: const TextStyle(fontSize: 18),),
                      const SizedBox(width: 10),
                      Container(
                        width: 100, // Set the fixed width
                        height: 40, // Set the fixed height
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Add border if needed
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100, // Ensure minimum width matches container width
                            ),
                            child: IntrinsicWidth(
                              child: MathField(
                                  controller: _intrinsicimpedence,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {}); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Wave Equation, } \\frac{d^{2}E_{x}}{dz^{2}} + k^2E_{x} = 0', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Wave Solution, } E_{x} = E_{0}e^{-jkz}', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  //Math.tex(' ', textStyle: const TextStyle(fontSize: 18)),
                  //const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        )
      ]
    );
  }
}
