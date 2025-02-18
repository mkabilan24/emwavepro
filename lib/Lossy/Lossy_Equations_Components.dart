import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/Shared/DirectionVectors.dart';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';


class LossyEquationComponentsDisplayWidget extends StatefulWidget {
  @override
  _LossyEquationComponentsDisplayWidgetState createState() => _LossyEquationComponentsDisplayWidgetState();
}

class _LossyEquationComponentsDisplayWidgetState extends State<LossyEquationComponentsDisplayWidget> {

  String _getWavePropagationAxis(String direction) {
    return direction[direction.length - 1];
  }

  Widget givenEcomponents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.blue[300],
          child: const Center(
            child: Text("E-Field Components", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                //No Change
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
                            controller: phaseangleE1,
                            decoration: const InputDecoration(
                              hintText: "Input",
                              border: InputBorder.none, // Remove the border
                            ),
                            keyboardType: MathKeyboardType.expression,
                            onChanged: (value) {
                              inputHandler(phaseangleE1);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Math.tex(
                    '\\text{ radians}',
                    textStyle: const TextStyle(fontSize: 18),
                  )
                ]
              ),
            ],
          )
        ),
      ],
    );
  }

  Widget givenHcomponents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.blue[300],
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("H-Field Components", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            controller: magneticabsoluteH1,
                            decoration: const InputDecoration(
                              hintText: "Input",
                              border: InputBorder.none, // Remove the border
                            ),
                            keyboardType: MathKeyboardType.expression,
                            onChanged: (value) {
                              if (!onchange) {
                                onchange = true;
                                //No Change
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
                            controller: phaseangleH1,
                            decoration: const InputDecoration(
                              hintText: "Input",
                              border: InputBorder.none, // Remove the border
                            ),
                            keyboardType: MathKeyboardType.expression,
                            onChanged: (value) {
                              inputHandler(phaseangleH1);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Math.tex(
                    '\\text{ radians}',
                    textStyle: const TextStyle(fontSize: 18),
                  )
                ]
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
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: PageView(
            children: <Widget>[
              if (givenfield == "E") givenEcomponents(),
              if (givenfield == "H") givenHcomponents(),
            ],
          ),
        ),
      ],
    );
  }
}

class LossyEquationComponentsDropdown extends StatefulWidget {
  @override
  _LossyEquationComponentsDropdownState createState() => _LossyEquationComponentsDropdownState();
}

class _LossyEquationComponentsDropdownState extends State<LossyEquationComponentsDropdown> {
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
              'Which Field is Given?',
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
                      givenfield = isSelected[0] ? "E" : "H"; 
                      magneticabsoluteH1.clear();
                      electricabsoluteE1.clear();
                      phaseangleE1.clear();
                      phaseangleH1.clear();
                    });
                  },
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text('E', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text('H', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        if (isExpanded) LossyEquationComponentsDisplayWidget(),
      ],
    );
  }
}