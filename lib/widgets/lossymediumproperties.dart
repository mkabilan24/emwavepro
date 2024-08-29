import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';

class LossyMediumPropertiesWidget extends StatefulWidget {
  @override
  _LossyMediumPropertiesWidgetState createState() => _LossyMediumPropertiesWidgetState();
}

class _LossyMediumPropertiesWidgetState extends State<LossyMediumPropertiesWidget> {
  MathFieldEditingController _relativepermeability = MathFieldEditingController();
  
  bool _isUpdating = false;

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
                  Math.tex('\\text{Conducting, } \\sigma \\neq 0', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Ampere\'s Law, } \\nabla \\times H = J_{c} + j\\omega\\varepsilon E = (\\sigma + j\\omega\\varepsilon)E = j\\omega\\varepsilon_{c}E', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Permittivity, } \\varepsilon_{c} = \\varepsilon - j \\frac{\\sigma}{\\omega}', textStyle: const TextStyle(fontSize: 18),),
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
                  Math.tex('\\text{Wave Number, } k_{c} = \\sqrt{\\omega^{2}\\mu\\varepsilon_{c}}', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Wave Equation, } \\frac{d^{2}E_{x}}{dz^{2}} + {k_{c}}^{2}E_{x} = 0', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Wave Solution, } E_{x} = E_{0}e^{-\\alpha z}e^{-j\\beta z}', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Attenuation Constant, } \\alpha \\neq 0', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Phase Constant, } \\beta \\gt k', textStyle: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 15),
                  Math.tex('\\text{Intrinsic Impedence, } \\eta_{c} = \\frac{\\mu}{\\varepsilon_{c}}', textStyle: const TextStyle(fontSize: 18),),
                  //const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
