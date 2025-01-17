import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/DirectionVectors.dart';

import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';

void calc_lossless_H(MathFieldEditingController electricabsoluteE, MathFieldEditingController magneticabsoluteH, int num) {
  if (lossless_intrinsicimpedance.isEmpty || electricabsoluteE.isEmpty) {
    magneticabsoluteH.clear();
    return;
  }
  double intrinsicimpedanceValue = convertMathExpressionToDouble(lossless_intrinsicimpedance);
  double electricabsoluteEValue = convertMathExpressionToDouble(electricabsoluteE);
  double magneticabsoluteHValue = electricabsoluteEValue / intrinsicimpedanceValue;
  updateDouble(magneticabsoluteH, magneticabsoluteHValue);
  print("|H_$num| = $magneticabsoluteHValue.");
}

void calc_lossless_E(MathFieldEditingController electricabsoluteE, MathFieldEditingController magneticabsoluteH, int num) {
  if (lossless_intrinsicimpedance.isEmpty || magneticabsoluteH.isEmpty) {
    electricabsoluteE.clear();
    return;
  }
  double intrinsicimpedanceValue = convertMathExpressionToDouble(lossless_intrinsicimpedance);
  double magneticabsoluteHValue = convertMathExpressionToDouble(magneticabsoluteH);
  double electricabsoluteEValue = intrinsicimpedanceValue * magneticabsoluteHValue;
  updateDouble(electricabsoluteE, electricabsoluteEValue);
  print("|E_$num| = $electricabsoluteEValue.");
}

class LosslessEquationComponentsDisplayWidget extends StatefulWidget {
  @override
  _LosslessEquationComponentsDisplayWidgetState createState() => _LosslessEquationComponentsDisplayWidgetState();
}

class _LosslessEquationComponentsDisplayWidgetState extends State<LosslessEquationComponentsDisplayWidget> {

  void _validateAllWaveVectors() {
    print("Validating Wave Vectors");
    print("a_E_Field_Propagation1: $a_E_Field_Propagation1");
    print("a_H_Field_Propagation1: $a_H_Field_Propagation1");
    print("a_k_Wave_Propagation1: $a_k_Wave_Propagation1");
    print("a_E_Field_Propagation2: $a_E_Field_Propagation2");
    print("a_H_Field_Propagation2: $a_H_Field_Propagation2");
    print("a_k_Wave_Propagation1: $a_k_Wave_Propagation2");

    bool RHRComponent1 = validateRHRWaveVectors(a_E_Field_Propagation1, a_H_Field_Propagation1, a_k_Wave_Propagation1);
    bool RHRComponent2 = validateRHRWaveVectors(a_E_Field_Propagation2, a_H_Field_Propagation2, a_k_Wave_Propagation2);

    bool isvalid = (RHRComponent1 && RHRComponent2);
    print("isvalid: $isvalid");

    if (numofcomponents == 2) {
      if ((_getWavePropagationAxis(a_E_Field_Propagation1) == _getWavePropagationAxis(a_E_Field_Propagation2)) || (_getWavePropagationAxis(a_H_Field_Propagation1) == _getWavePropagationAxis(a_H_Field_Propagation2))) {
        isvalid = false;
      }
      if (_getWavePropagationAxis(a_k_Wave_Propagation1) != _getWavePropagationAxis(a_k_Wave_Propagation2)) {
        isvalid = false;
      }
    }
    if (!isvalid) {
      snackbarController.showPermanentErrorSnackBar(context, "Direction Vectors are Invalid!");
    } else {
      snackbarController.hideErrorSnackBar();
    }
  }

  String _getWavePropagationAxis(String direction) {
    return direction[direction.length - 1];
  }

  Widget component1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (numofcomponents == 2) Container(
          color: Colors.blue[300],
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("1st Component", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 150),
                Text("Swipe Right", style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
        if (numofcomponents == 1) Container(
          color: Colors.blue[300],
          child: const Center(
            child: Text("Only Component", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
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
                            _validateAllWaveVectors();
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
                      border: Border.all(
                          color: Colors.grey), // Add border if needed
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth:
                              100, // Ensure minimum width matches container width
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
                                if (!inputHandler(electricabsoluteE1)) {
                                  calc_lossless_H(
                                      electricabsoluteE1, magneticabsoluteH1, 1);
                                }
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
                ]),
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
                            _validateAllWaveVectors();
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
                      border: Border.all(
                          color: Colors.grey), // Add border if needed
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth:
                              100, // Ensure minimum width matches container width
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
                                if (!inputHandler(magneticabsoluteH1)) {
                                  calc_lossless_E(
                                    electricabsoluteE1, magneticabsoluteH1, 1);
                                }
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
                      border: Border.all(
                          color: Colors.grey), // Add border if needed
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth:
                              100, // Ensure minimum width matches container width
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
                              inputHandler(phaseangle1);
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
                ]
              ),
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
                          _validateAllWaveVectors();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ],
    );
  }

  Widget component2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.blue[300],
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_left),
                Text("Swipe Left", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 150),
                Text("2nd Component", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
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
                        initialValue: a_E_Field_Propagation2,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_E_Field_Propagation2 = newValue;
                            _validateAllWaveVectors();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Math.tex(
                    "\\text{Amplitude of E-Field, }E_{${_getWavePropagationAxis(a_E_Field_Propagation2)}} = ",
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 80, // Set the fixed width
                    height: 40, // Set the fixed height
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey), // Add border if needed
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth:
                              100, // Ensure minimum width matches container width
                        ),
                        child: IntrinsicWidth(
                          child: MathField(
                            controller: electricabsoluteE2,
                            decoration: const InputDecoration(
                              hintText: "Input",
                              border: InputBorder.none, // Remove the border
                            ),
                            keyboardType: MathKeyboardType.expression,
                            onChanged: (value) {
                              if (!onchange) {
                                onchange = true;
                                if (!inputHandler(electricabsoluteE2)) {
                                  calc_lossless_H(
                                    electricabsoluteE2, magneticabsoluteH2, 1);
                                }
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
                ]),
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
                        initialValue: a_H_Field_Propagation2,
                        options: vect_options,
                        onChanged: (newValue) {
                          setState(() {
                            a_H_Field_Propagation2 = newValue;
                            _validateAllWaveVectors();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Math.tex(
                    "\\text{Amplitude of H-Field, }H_{${_getWavePropagationAxis(a_H_Field_Propagation2)}} = ",
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 80, // Set the fixed width
                    height: 40, // Set the fixed height
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey), // Add border if needed
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth:
                              100, // Ensure minimum width matches container width
                        ),
                        child: IntrinsicWidth(
                          child: MathField(
                            controller: magneticabsoluteH2,
                            decoration: const InputDecoration(
                              hintText: "Input",
                              border: InputBorder.none, // Remove the border
                            ),
                            keyboardType: MathKeyboardType.expression,
                            onChanged: (value) {
                              if (!onchange) {
                                onchange = true;
                                if (!inputHandler(magneticabsoluteH2)) {
                                  calc_lossless_E(
                                    electricabsoluteE2, magneticabsoluteH2, 1);
                                }
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
                      border: Border.all(
                          color: Colors.grey), // Add border if needed
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth:
                              100, // Ensure minimum width matches container width
                        ),
                        child: IntrinsicWidth(
                          child: MathField(
                            controller: phaseangle2,
                            decoration: const InputDecoration(
                              hintText: "Input",
                              border: InputBorder.none, // Remove the border
                            ),
                            keyboardType: MathKeyboardType.expression,
                            onChanged: (value) {
                              inputHandler(phaseangle2);
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
                ]
              ),
              Row(
                children: [
                  Math.tex(
                    '\\text{Wave propagation: }\\vec{a}_{k}=',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MathDropdown(
                      initialValue: a_k_Wave_Propagation2,
                      options: vect_options,
                      onChanged: (newValue) {
                        setState(() {
                          a_k_Wave_Propagation2 = newValue;
                          _validateAllWaveVectors();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 370,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: PageView(
            children: <Widget>[
              component1(),
              if (numofcomponents == 2) component2(),
            ],
          ),
        ),
      ],
    );
  }
}

class LosslessEquationComponentsDropdown extends StatefulWidget {
  @override
  _LosslessEquationComponentsDropdownState createState() => _LosslessEquationComponentsDropdownState();
}

class _LosslessEquationComponentsDropdownState extends State<LosslessEquationComponentsDropdown> {
  bool isExpanded = false; // Controls visibility of widget content
  List<bool> isSelected = [true, false];

  Widget numofcomponentstoggle() {
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'No. of Components:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 10), // Add some space between the text and the toggle buttons
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ToggleButtons(
                  borderColor: Colors.blue,
                  fillColor: Colors.lightBlueAccent,
                  borderWidth: 2,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.white,
                  isSelected: isSelected,
                  hoverColor: Colors.blue,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                      numofcomponents = index + 1;
                      print("Number of Components: $numofcomponents");
                      if (numofcomponents == 1) {
                        electricabsoluteE2.clear();
                        magneticabsoluteH2.clear();
                        phaseangle2.clear();
                      }
                    });
                  },
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text('1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text('2', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        numofcomponentstoggle(),
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
                const Text("Components of EM Wave", style: TextStyle(fontSize: 16,)),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) LosslessEquationComponentsDisplayWidget(),
      ],
    );
  }
}