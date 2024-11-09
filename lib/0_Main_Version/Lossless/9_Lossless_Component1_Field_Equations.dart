import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Shared/DirectionVectors.dart';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';

void calc_lossless_H1() {
  if (lossless_intrinsicimpedance.isEmpty || electricabsoluteE1.isEmpty) {
    magneticabsoluteH1.clear();
    return;
  }
  double intrinsicimpedanceValue = convertMathExpressionToDouble(lossless_intrinsicimpedance);
  double electricabsoluteE1Value = convertMathExpressionToDouble(electricabsoluteE1);
  double magneticabsoluteH1Value = electricabsoluteE1Value / intrinsicimpedanceValue;
  updateDouble(magneticabsoluteH1, magneticabsoluteH1Value);
  print("|H_1| = $magneticabsoluteH1Value.");
}

void calc_lossless_E1() {
  if (lossless_intrinsicimpedance.isEmpty || magneticabsoluteH1.isEmpty) {
    electricabsoluteE1.clear();
    return;
  }
  double intrinsicimpedanceValue = convertMathExpressionToDouble(lossless_intrinsicimpedance);
  double magneticabsoluteH1Value = convertMathExpressionToDouble(magneticabsoluteH1);
  double electricabsoluteE1Value = intrinsicimpedanceValue * magneticabsoluteH1Value;
  updateDouble(electricabsoluteE1, electricabsoluteE1Value);
  print("|E_1| = $electricabsoluteE1Value.");
}

class Component1EquationsDisplayWidget extends StatefulWidget {
  @override
  _Component1EquationsDisplayWidgetState createState() => _Component1EquationsDisplayWidgetState();
}

class _Component1EquationsDisplayWidgetState extends State<Component1EquationsDisplayWidget> {

  void _validateWaveVectors() {
    bool isvalid = validateWaveVectors(
        a_E_Field_Propagation1, a_H_Field_Propagation1, a_k_Wave_Propagation1);
    if (!isvalid) {
      snackbarController.showPermanentErrorSnackBar(
          context, "Direction Vectors are Invalid!");
    } else {
      snackbarController.hideErrorSnackBar();
    }
  }

  String _getWavePropagationAxis(String direction) {
    return direction[direction.length - 1];
  }

  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.all(5.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Math.tex(
                        '\\text{E-Field propagation: }\\vec{a}_{E}=',
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MathDropdown(
                          initialValue: a_E_Field_Propagation1,
                          options: vect_options,
                          onChanged: (newValue) {
                            setState(() {
                              a_E_Field_Propagation1 = newValue;
                              _validateWaveVectors();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    Math.tex(
                      "\\text{Amplitude of E-Field, }E_{${_getWavePropagationAxis(a_E_Field_Propagation1)}} = ",
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 80, // Set the fixed width
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
                              controller: electricabsoluteE1,
                              decoration: const InputDecoration(
                                hintText: "Input",
                                border: InputBorder.none, // Remove the border
                              ),
                              keyboardType: MathKeyboardType.expression,
                              onChanged: (value) {
                                if (!onchange) {
                                  onchange = true;
                                  calc_lossless_H1();
                                  setState(() {});
                                  onchange = false;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Math.tex(
                      '\\text{ V/m}',
                      textStyle: const TextStyle(fontSize: 18),
                    )
                  ]
                ),
                const SizedBox(height: 10),
                Row(
                children: [
                  Math.tex(
                    '\\text{H-Field propagation: }\\vec{a}_{H}=',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MathDropdown(
                      initialValue: a_H_Field_Propagation1,
                      options: vect_options,
                      onChanged: (newValue) {
                        setState(() {
                          a_H_Field_Propagation1 = newValue;
                          _validateWaveVectors();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(children: [
                Math.tex(
                  "\\text{Amplitude of H-Field, }H_{${_getWavePropagationAxis(a_H_Field_Propagation1)}} = ",
                  textStyle: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 80, // Set the fixed width
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
                          controller: magneticabsoluteH1,
                          decoration: const InputDecoration(
                            hintText: "Input",
                            border: InputBorder.none, // Remove the border
                          ),
                          keyboardType: MathKeyboardType.expression,
                          onChanged: (value) {
                            if (!onchange) {
                              onchange = true;
                              calc_lossless_E1();
                              setState(() {});
                              onchange = false;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Math.tex(
                  '\\text{ A/m}',
                  textStyle: const TextStyle(fontSize: 18),
                )
              ]),
              const SizedBox(height: 10),
              Row(
                children: [
                  Math.tex(
                    '\\text{Wave propagation: }\\vec{a}_{k}=',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MathDropdown(
                      initialValue: a_k_Wave_Propagation1,
                      options: vect_options,
                      onChanged: (newValue) {
                        setState(() {
                          a_k_Wave_Propagation1 = newValue;
                          _validateWaveVectors();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(children: [
                Math.tex(
                  "\\text{Phase angle, φ =}",
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
                          controller: phaseangle1,
                          decoration: const InputDecoration(
                            hintText: "Input",
                            border: InputBorder.none, // Remove the border
                          ),
                          keyboardType: MathKeyboardType.expression,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Math.tex(
                  '\\text{ degrees}',
                  textStyle: const TextStyle(fontSize: 18),
                )
              ]),
              ],
            )
          )        
        ],
    );
  }
}

class Component1EquationsDropdown extends StatefulWidget {
  @override
  _Component1EquationsDropdownState createState() => _Component1EquationsDropdownState();
}

class _Component1EquationsDropdownState extends State<Component1EquationsDropdown> {
  bool isExpanded = false; // Controls visibility of widget content

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded; // Toggle expansion
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Components of EM Wave in Lossless Medium"),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) Component1EquationsDisplayWidget(),
      ],
    );
  }
}