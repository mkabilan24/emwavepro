import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:emwavepro/Archive/Calculations/update_eqns.dart';
import 'package:emwavepro/Archive/Calculations/directionvectors.dart';

class Component1EquationsWidget extends StatefulWidget {
  @override
  _1ComponentEquationsWidgetState createState() => _1ComponentEquationsWidgetState();
}

class _1ComponentEquationsWidgetState extends State<Component1EquationsWidget> {

  String message = "";

  //1 Component in E or H Field Equations
  //Only one component in E or H Field Equations
  final MathFieldEditingController _E0 = MathFieldEditingController();
  final MathFieldEditingController _H0 = MathFieldEditingController();
  final MathFieldEditingController _phi = MathFieldEditingController();

  //Default directions of EM Wave
  String a_E_Field_Propagation_1 = '+\\vec{a}_x';
  String a_H_Field_Propagation_1 = '+\\vec{a}_y';
  String a_k_Wave_Propagation_1 = '+\\vec{a}_z';

  //Default Equations of EM Wave
  String E_Time_Domain_Equation_1 = '\\vec{E} =  +\\vec{a}_x |E_{0}|\\cos(\\omega t - kz + \\phi)';
  String E_Phasor_Domain_Equation_1 = '\\vec{E} =  +\\vec{a}_x |E_{0}|\\angle\\phi e^{-jkz}';

  String H_Time_Domain_Equation_1 = '\\vec{H} =  +\\vec{a}_y |H_{0}|\\cos(\\omega t - kz + \\phi)';
  String H_Phasor_Domain_Equation_1 = '\\vec{H} =  +\\vec{a}_y |H_{0}|\\angle\\phi e^{-jkz}';

  void _update1CompEqns() {
    setState(() {
      List equations = update1CompEqns(a_E_Field_Propagation_1, a_H_Field_Propagation_1, a_k_Wave_Propagation_1, _E0, _H0, _phi);
      message = equations[0];
      E_Time_Domain_Equation_1 = equations[1];
      E_Phasor_Domain_Equation_1 = equations[2];
      H_Time_Domain_Equation_1 = equations[3];
      H_Phasor_Domain_Equation_1 = equations[4];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  if (message.isNotEmpty) 
                    Text(
                      message,
                      style: const TextStyle(fontSize: 18),
                    ),
                  Math.tex(
                    E_Time_Domain_Equation_1,
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Math.tex(
                    E_Phasor_Domain_Equation_1,
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Math.tex(
                    H_Time_Domain_Equation_1,
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Math.tex(
                    H_Phasor_Domain_Equation_1,
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),

        Row(
          children: [
            Math.tex('\\text{E-Field propagation: }\\vec{a}_{E}=', textStyle: const TextStyle(fontSize: 18),),
            const SizedBox(width: 10),
            Expanded(
              child: MathDropdown(
                initialValue: a_E_Field_Propagation_1,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_E_Field_Propagation_1 = newValue;
                    a_k_Wave_Propagation_1 = wave_propagation_result(a_E_Field_Propagation_1, a_H_Field_Propagation_1);
                    _update1CompEqns();
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Math.tex('\\text{H-Field propagation: }\\vec{a}_H=', textStyle: const TextStyle(fontSize: 18),),
            const SizedBox(width: 10),
            Expanded(
              child: MathDropdown(
                initialValue: a_H_Field_Propagation_1,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_H_Field_Propagation_1 = newValue;
                    a_k_Wave_Propagation_1 = wave_propagation_result(a_E_Field_Propagation_1, a_H_Field_Propagation_1);
                    _update1CompEqns();
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
        //Wave Propagation
        Math.tex('\\text{Wave propagation: }\\vec{a}_k= $a_k_Wave_Propagation_1', textStyle: const TextStyle(fontSize: 18),),
        const SizedBox(height: 20),
        Row(
          children: [
            //E_{0}
            Math.tex('|E_{0}|=', textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _E0,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update1CompEqns(),
              ),
            ),
            const SizedBox(width: 10),

            //H_{0}
            Math.tex('|H_{0}|=', textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _H0,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update1CompEqns(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        //phi
        Row(
          children: [
            Math.tex('\\phi=', textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _phi,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update1CompEqns(),
              ),
            ),
            const SizedBox(width: 170),
          ]
        ),
      ],
    );
  }
}
