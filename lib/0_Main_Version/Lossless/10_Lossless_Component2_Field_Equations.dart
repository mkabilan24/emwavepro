import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Shared/DirectionVectors.dart';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';

int numofcomponents = 1;

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

class Component2EquationsDisplayWidget extends StatefulWidget {
  @override
  _Component2EquationsDisplayWidgetState createState() => _Component2EquationsDisplayWidgetState();
}

class _Component2EquationsDisplayWidgetState extends State<Component2EquationsDisplayWidget> {

  void _validateWaveVectors(String a_E_Field_Propagation, String a_H_Field_Propagation, String a_k_Wave_Propagation) {
    bool isvalid = validateWaveVectors(a_E_Field_Propagation, a_H_Field_Propagation, a_k_Wave_Propagation);
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

  Widget component1() {
    return 
      Padding(padding: const EdgeInsets.all(5.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(5.0),
              child: Center(child: Text("1st Component"),
             ),
            ),
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
                        _validateWaveVectors(a_E_Field_Propagation1, a_H_Field_Propagation1, a_k_Wave_Propagation1);
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
                            calc_lossless_H(electricabsoluteE1, magneticabsoluteH1, 1);
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
                    _validateWaveVectors(a_E_Field_Propagation1, a_H_Field_Propagation1, a_k_Wave_Propagation1);
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
                        calc_lossless_E(electricabsoluteE1, magneticabsoluteH1, 1);
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
                    _validateWaveVectors(a_E_Field_Propagation1, a_H_Field_Propagation1, a_k_Wave_Propagation1);
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
    );
  }

  Widget component2() {
    return 
      Padding(padding: const EdgeInsets.all(5.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(5.0),
              child: Center(child: Text("2nd Component"),
             ),
            ),
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
                        _validateWaveVectors(a_E_Field_Propagation2, a_H_Field_Propagation2, a_k_Wave_Propagation2);
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
                        controller: electricabsoluteE2,
                        decoration: const InputDecoration(
                          hintText: "Input",
                          border: InputBorder.none, // Remove the border
                        ),
                        keyboardType: MathKeyboardType.expression,
                        onChanged: (value) {
                          if (!onchange) {
                            onchange = true;
                            calc_lossless_H(electricabsoluteE2, magneticabsoluteH2, 2);
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
                initialValue: a_H_Field_Propagation2,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_H_Field_Propagation2 = newValue;
                    _validateWaveVectors(a_E_Field_Propagation2, a_H_Field_Propagation2, a_k_Wave_Propagation2);
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
                    controller: magneticabsoluteH2,
                    decoration: const InputDecoration(
                      hintText: "Input",
                      border: InputBorder.none, // Remove the border
                    ),
                    keyboardType: MathKeyboardType.expression,
                    onChanged: (value) {
                      if (!onchange) {
                        onchange = true;
                        calc_lossless_E(electricabsoluteE2, magneticabsoluteH2, 2);
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
                initialValue: a_k_Wave_Propagation2,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_k_Wave_Propagation2 = newValue;
                    _validateWaveVectors(a_E_Field_Propagation2, a_H_Field_Propagation2, a_k_Wave_Propagation2);
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
    );
}

Widget build(BuildContext context) {
  return Container(
    height: 400, // Adjust height as needed
      child: PageView(
        children: <Widget>[
          component1(),
          component2(),        
          ],
      ),
    );
  }
}

class Component2EquationsDropdown extends StatefulWidget {
  @override
  _Component2EquationsDropdownState createState() => _Component2EquationsDropdownState();
}

class _Component2EquationsDropdownState extends State<Component2EquationsDropdown> {
  bool isExpanded = false; // Controls visibility of widget content
  List<bool> isSelected = [true, false];

  Widget numofcomponentstoggle() {
    return Padding(padding: const EdgeInsets.all(5.0),
      child:
        Row(children: [
          const Text(
            'No. of Components:',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 10), // Add some space between the text and the toggle buttons
          ToggleButtons(
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
        ],
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
                const Text("Components of EM Wave in Lossless Medium (2)"),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) Component2EquationsDisplayWidget(),
      ],
    );
  }
}