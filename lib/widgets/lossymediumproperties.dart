import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:emwavepro/Calculations/complex_math.dart';

class LossyMediumPropertiesWidget extends StatefulWidget {
  @override
  _LossyMediumPropertiesWidgetState createState() => _LossyMediumPropertiesWidgetState();
}

class _LossyMediumPropertiesWidgetState extends State<LossyMediumPropertiesWidget> {
  MathFieldEditingController _conductivity = MathFieldEditingController();
  MathFieldEditingController _angularfreq = MathFieldEditingController();
  MathFieldEditingController _freq = MathFieldEditingController();

  MathFieldEditingController _realtivepermittivity = MathFieldEditingController();
  MathFieldEditingController _relativepermeability = MathFieldEditingController();

  MathFieldEditingController _permittivity = MathFieldEditingController();
  MathFieldEditingController _permeability = MathFieldEditingController();

  MathFieldEditingController _alpha = MathFieldEditingController();
  MathFieldEditingController _beta = MathFieldEditingController();
  MathFieldEditingController _intrinsicimpedance = MathFieldEditingController();

  bool _isUpdating = false;
  double pi = 3.14159265;
  double sigma_over_omega = 0;
  List<Complex> wave_number_roots = [];
  Complex permittivity = Complex(0, 0);
  Complex propagation_constant = Complex(0, 0);
  Complex intrinsic_impedance = Complex(0, 0);

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

  void calc_complex_permittivity() {
    if (_isUpdating) return;

    _isUpdating = true;

    // LaTeX equation: k = ??
    if (_angularfreq.isEmpty || _realtivepermittivity.isEmpty) {
      // Clear Input Field including '0'
      _permittivity.clear();
      _isUpdating = false;
      return;
    }

    if (!_realtivepermittivity.isEmpty) {
      double realtivepermittivityValue = double.parse(_realtivepermittivity.currentEditingValue());

      double permittivityValue = realtivepermittivityValue * ((1 * pow(10, -9))/(36*pi));
      final expression = Parser().parse(permittivityValue.toString());
      _permittivity.updateValue(expression);
      print("The value of Permittivity is: $permittivityValue");
    }

    _isUpdating = false;
  }

  void calc_permeability() {
    if (_isUpdating) return;

    _isUpdating = true;

    // LaTeX equation: u = ??
    if (_relativepermeability.isEmpty) {
      // Clear Input Field including '0'
      _permeability.clear();
      _isUpdating = false;
      return;
    }

    if (!_relativepermeability.isEmpty) {
      double realtivepermeabilityValue = double.parse(_relativepermeability.currentEditingValue());

      double permeabilityValue = realtivepermeabilityValue * (4 * pi * pow(10, -7));
      final expression = Parser().parse(permeabilityValue.toString());
      _permeability.updateValue(expression);
      print("The value of Permeability is: $permeabilityValue");
    }

    _isUpdating = false;
  }

  void calc_wave_number_roots() {
    if (_isUpdating) return;

    _isUpdating = true;

    // LaTeX equation: k =
    if (_angularfreq.isEmpty || _relativepermeability.isEmpty || _permittivity.isEmpty) {
      // Clear Input Field including '0'
      wave_number_roots = [];
      _isUpdating = false;
      return;
    }

    if (!_angularfreq.isEmpty && !_relativepermeability.isEmpty && !_realtivepermittivity.isEmpty) {
      double angularfreqValue = double.parse(_angularfreq.currentEditingValue());
      double realtivepermittivityValue = double.parse(_realtivepermittivity.currentEditingValue());
      double relativepermeabilityValue = double.parse(_relativepermeability.currentEditingValue());

      double realvalue = pow(angularfreqValue, 2) * relativepermeabilityValue * (4 * pi * pow(10, -7)) * realtivepermittivityValue * ((1 * pow(10, -9))/(36*pi));
      double imaginaryvalue = pow(angularfreqValue, 2) * relativepermeabilityValue * (4 * pi * pow(10, -7)) * sigma_over_omega;

      Complex z = Complex(realvalue, -imaginaryvalue);
  
      // Compute the 2 roots of the complex number
      wave_number_roots = z.nthRoots(2);
      print("The value of Complex WaveNumber is: $wave_number_roots");
    }

    _isUpdating = false;
  }
  
  void calc_sigma_over_omega() {
    if (_isUpdating) return;

    _isUpdating = true;

    if (!_conductivity.isEmpty && !_angularfreq.isEmpty) {
      double angularfreqValue = double.parse(_angularfreq.currentEditingValue());
      double conductivityValue = double.parse(_conductivity.currentEditingValue());

      sigma_over_omega = conductivityValue/angularfreqValue;
      print("The value of sigma/omega is: $sigma_over_omega");
    }

    _isUpdating = false;
  }

  void get_complex_permittivity() {
    permittivity = Complex(_permittivity.currentEditingValue() as double, sigma_over_omega);
    print(permittivity.toString());
  }

  void get_propagation_constant() {
    if (!wave_number_roots.isEmpty) {

      //IMPORTANTIMPORTANTIMPORTANTIMPORTANTIMPORTANT
      //Assumption: Taking only the first root
      Complex wave_number_root = wave_number_roots[0];
      print(wave_number_root);

      //propagation_constant = wave_number_root * j
      propagation_constant = Complex.multiply(wave_number_root, Complex(0, 1));
      print("The value of Propagation Constant is: ${propagation_constant.toString()}");
    }

    _alpha.updateValue(Parser().parse(propagation_constant.getReal().toString()));
    print("The value of Attenuation Constant (alpha) is: ${_alpha.currentEditingValue()}");

    _beta.updateValue(Parser().parse(propagation_constant.getImaginary().toString()));
    print("The value of Phase Constant (beta) is: ${_beta.currentEditingValue()}");

    _isUpdating = false;
  }

  void calc_intrinsic_impedance() {
    if (_isUpdating) return;

    _isUpdating = true;

    if (!_permeability.isEmpty && !propagation_constant.isEmpty()) {
      print(_permeability.currentEditingValue());
      double permeabilityValue = double.parse(_permeability.currentEditingValue());

      Complex intrinsic_impedanceValue = Complex.divide(Complex(permeabilityValue, 0), propagation_constant);
      print(intrinsic_impedanceValue.toString());

      ///////
      //Important How to store a complex number in MathFieldEditting Controller
      _intrinsicimpedance.updateValue(Parser().parse('${intrinsic_impedanceValue.getReal()}+${intrinsic_impedanceValue.getImaginary()}j'));
      print("The value of Intrinsic impedance is: ${intrinsic_impedanceValue.toString()}");
    }

    _isUpdating = false;
  }
  
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        "Lossy Medium Properties",
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
                  Row(
                    children: [
                      Math.tex('\\text{Conducting, } \\sigma = ', textStyle: const TextStyle(fontSize: 18),),
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
                                  controller: _conductivity,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {
                                      calc_sigma_over_omega();
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Math.tex('\\neq 0', textStyle: const TextStyle(fontSize: 18),),
                    ],
                  ),
                  // Math.tex('\\text{Conducting, } \\sigma \\neq 0', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex('\\text{Frequency, }f = ', textStyle: const TextStyle(fontSize: 18),),
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
                                      calc_wave_number_roots();
                                      get_propagation_constant();
                                      calc_sigma_over_omega();
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
                      Math.tex('\\text{Angular Frequency, }\\omega = 2\\pi f = ', textStyle: const TextStyle(fontSize: 18),),
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
                                      calc_sigma_over_omega();
                                      calc_wave_number_roots();
                                      get_propagation_constant();
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
                      Math.tex('\\text{Permittivity, } \\varepsilon = \\varepsilon_{r}\\varepsilon_{0} = ', textStyle: const TextStyle(fontSize: 18),),
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
                                    setState(() {
                                      calc_complex_permittivity();
                                      calc_wave_number_roots();
                                      get_propagation_constant();
                                      calc_intrinsic_impedance();
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Math.tex('\\varepsilon_{0}', textStyle: const TextStyle(fontSize: 18),),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex('\\text{Complex Permittivity, } \\varepsilon_{c} = \\varepsilon - j \\frac{\\sigma}{\\omega} = ${_permittivity.isEmpty ? '\\varepsilon_{r}\\varepsilon_{0}' : _permittivity.currentEditingValue()} - j ${sigma_over_omega == 0 ? '\\frac{\\sigma}{\\omega}' : sigma_over_omega}', textStyle: const TextStyle(fontSize: 18),),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex('\\text{Permeability, }\\mu = \\mu_{r}\\mu_{0} = ', textStyle: const TextStyle(fontSize: 18),),
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
                                    setState(() {
                                      calc_wave_number_roots();
                                      get_propagation_constant();
                                      calc_permeability();
                                      calc_intrinsic_impedance();
                                    }); // Trigger a rebuild to update the UI
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
                  Math.tex('\\text{Ampere\'s Law, } \\nabla \\times H = J_{c} + j\\omega\\varepsilon E = (\\sigma + j\\omega\\varepsilon)E = j\\omega\\varepsilon_{c}E', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Wave Number, } k_{c} = \\sqrt{\\omega^{2}\\mu\\varepsilon_{c}} = ${wave_number_roots.isEmpty ? "?" : wave_number_roots}', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Propagation Constant, } \\gamma = \\alpha + j\\beta = j \\omega \\sqrt{\\mu\\varepsilon_{c}} = $propagation_constant', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex('\\text{Attenuation Constant, } \\alpha = ', textStyle: const TextStyle(fontSize: 18),),
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
                                  controller: _alpha,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {
                                      //add functions
                                    }); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Math.tex('\\neq 0',textStyle: const TextStyle(fontSize: 18),),
                    ]
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex('\\text{Phase Constant, } \\beta = ', textStyle: const TextStyle(fontSize: 18),),
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
                                  controller: _beta,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {
                                      //add functions
                                    }); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Math.tex('\\gt k',textStyle: const TextStyle(fontSize: 18),),
                    ]
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Math.tex('\\text{Intrinsic impedance, } \\eta_{c} = \\frac{\\mu}{\\varepsilon_{c}} = ', textStyle: const TextStyle(fontSize: 18),),
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
                                  controller: _intrinsicimpedance,
                                  decoration: const InputDecoration(
                                    hintText: "Input",
                                    border: InputBorder.none, // Remove the border
                                  ),
                                  keyboardType: MathKeyboardType.expression,
                                  onChanged: (newvalue) {
                                    setState(() {
                                      //add functions
                                    }); // Trigger a rebuild to update the UI
                                  }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ]
                  ),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Wave Equation, } \\frac{d^{2}E_{x}}{dz^{2}} + {k_{c}}^{2}E_{x} = 0', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Wave Solution, } E_{x} = E_{0}e^{-\\alpha z}e^{-j\\beta z}', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
