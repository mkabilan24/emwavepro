import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:emwavepro/Calculations/update_eqns.dart';
import 'package:emwavepro/Calculations/directionvectors.dart';

class Component2EquationsWidget extends StatefulWidget {
  @override
  _2ComponentEquationsWidgetState createState() => _2ComponentEquationsWidgetState();
}

class _2ComponentEquationsWidgetState extends State<Component2EquationsWidget> {

  String message = "";

  //2 Components in E or H Field Equations
  //First Component of Equation
  final MathFieldEditingController _E01 = MathFieldEditingController();
  final MathFieldEditingController _H01 = MathFieldEditingController();
  final MathFieldEditingController _phi1 = MathFieldEditingController();

  //Default Variable names of First Component of Equation
  String E01 = '|E_{0x}|=';
  String H01 = '|H_{0y}|=';
  String phi1 = '\\phi_x=';

  //Default Directions of the First Component of the EM Wave
  String a_E_Field_Propagation_2_1 = '+\\vec{a}_x';
  String a_H_Field_Propagation_2_1 = '+\\vec{a}_y';

  //Default Equations of the First Component of the EM Wave
  String E_Time_Domain_Equation_2_1 = '+\\vec{a}_x |E_{0x}|\\cos(\\omega t - kz + \\phi_x)';
  String E_Phasor_Domain_Equation_2_1 = '+\\vec{a}_x |E_{0x}|\\angle\\phi_xe^{-jkz}';

  String H_Time_Domain_Equation_2_1 = '+\\vec{a}_y |H_{0y}|\\cos(\\omega t - kz + \\phi_y)';
  String H_Phasor_Domain_Equation_2_1 = '+\\vec{a}_y |H_{0y}|\\angle\\phi_ye^{-jkz}';

  //Second Component of Equation
  final MathFieldEditingController _E02 = MathFieldEditingController();
  final MathFieldEditingController _H02 = MathFieldEditingController();
  final MathFieldEditingController _phi2 = MathFieldEditingController();

  //Default Variable names of First Component of Equation
  String E02 = '|E_{0y}|=';
  String H02 = '|H_{0x}|=';
  String phi2 = '\\phi_y=';

  //Default Directions of the Second Component of the EM Wave
  String a_E_Field_Propagation_2_2 = '+\\vec{a}_y';
  String a_H_Field_Propagation_2_2 = '-\\vec{a}_x';

  //Default Equations of the Second Component of the EM Wave
  String E_Time_Domain_Equation_2_2 = '+\\vec{a}_y |E_{0y}|\\cos(\\omega t - kz + \\phi_y)';
  String E_Phasor_Domain_Equation_2_2 = '+\\vec{a}_y |E_{0y}|\\angle\\phi_ye^{-jkz}';

  String H_Time_Domain_Equation_2_2 = '-\\vec{a}_x |H_{0x}|\\cos(\\omega t - kz + \\phi_x)';
  String H_Phasor_Domain_Equation_2_2 = '-\\vec{a}_x |H_{0x}|\\angle\\phi_xe^{-jkz}';

  //Common Wave Propagation of 2 component Equation
  String a_k_Wave_Propagation_2 = '+\\vec{a}_z';

  //Polarisation
  String polarisation = "";

  void _update2CompEqns() {
    setState(() {
      List comp1equations = update2CompEqns("1", a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_k_Wave_Propagation_2, _E01, _H01, _phi1, E01, H01, phi1);
       message = comp1equations[0];
       E_Time_Domain_Equation_2_1 = comp1equations[1];
       E_Phasor_Domain_Equation_2_1 = comp1equations[2];
       H_Time_Domain_Equation_2_1 = comp1equations[3];
       H_Phasor_Domain_Equation_2_1 = comp1equations[4];
    
      List comp2equations = update2CompEqns("2", a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2, a_k_Wave_Propagation_2, _E02, _H02, _phi2, E02, H02, phi2);
       message = comp2equations[0];
       E_Time_Domain_Equation_2_2 = comp2equations[1];
       E_Phasor_Domain_Equation_2_2 = comp2equations[2];
       H_Time_Domain_Equation_2_2 = comp2equations[3];
       H_Phasor_Domain_Equation_2_2 = comp2equations[4];

      //polarisation = determinepolarisation(_E01, _E02, _phi1, _phi2);
    });
  }

  String _getdirection(String vectorstring) {
    return vectorstring[vectorstring.length-1];
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
                    "\\vec{E} = $E_Time_Domain_Equation_2_1 $E_Time_Domain_Equation_2_2",
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Math.tex(
                    "\\vec{E} = $E_Phasor_Domain_Equation_2_1 $E_Phasor_Domain_Equation_2_2",
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Math.tex(
                    "\\vec{H} = $H_Time_Domain_Equation_2_1 $H_Time_Domain_Equation_2_2",
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Math.tex(
                    "\\vec{H} = $H_Phasor_Domain_Equation_2_1 $H_Phasor_Domain_Equation_2_2",
                    mathStyle: MathStyle.display, // Render the equation using LaTeX
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 15),
        Math.tex('\\text{E-Field propagation: }', textStyle: const TextStyle(fontSize: 18),),
        const SizedBox(height: 15),
        Row(
          children: [
            Math.tex('\\vec{a}_{E1}=', textStyle: const TextStyle(fontSize: 18),),
            const SizedBox(width: 10),
            Expanded(
              child: MathDropdown(
                initialValue: a_E_Field_Propagation_2_1,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_E_Field_Propagation_2_1 = newValue;
                    a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                    E01 = "|E_{0${_getdirection(newValue)}}|=";
                    phi1 = "\\phi_${_getdirection(newValue)} = ";
                    _update2CompEqns();
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Math.tex('\\vec{a}_{E2}=', textStyle: const TextStyle(fontSize: 18),),
            const SizedBox(width: 10),
            Expanded(
              child: MathDropdown(
                initialValue: a_E_Field_Propagation_2_2,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_E_Field_Propagation_2_2 = newValue;
                    a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                    E02 = "|E_{0${_getdirection(newValue)}}|=";
                    phi2 = "\\phi_${_getdirection(newValue)} = ";
                    _update2CompEqns();
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),
        Math.tex('\\text{H-Field propagation: }', textStyle: const TextStyle(fontSize: 18),),
        const SizedBox(height: 15),
        Row(
          children: [
            Math.tex('\\vec{a}_{H1}=', textStyle: const TextStyle(fontSize: 18),),
            const SizedBox(width: 10),
            Expanded(
              child: MathDropdown(
                initialValue: a_H_Field_Propagation_2_1,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_H_Field_Propagation_2_1 = newValue;
                    a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                    H01 = "|H_{0${_getdirection(newValue)}}|=";
                    _update2CompEqns();
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Math.tex('\\vec{a}_{H2}=', textStyle: const TextStyle(fontSize: 18),),
            const SizedBox(width: 10),
            Expanded(
              child: MathDropdown(
                initialValue: a_H_Field_Propagation_2_2,
                options: vect_options,
                onChanged: (newValue) {
                  setState(() {
                    a_H_Field_Propagation_2_2 = newValue;
                    a_k_Wave_Propagation_2 = wave_propagation_result_2_Comp(a_E_Field_Propagation_2_1, a_H_Field_Propagation_2_1, a_E_Field_Propagation_2_2, a_H_Field_Propagation_2_2);
                    H02 = "|H_{0${_getdirection(newValue)}}|=";
                    _update2CompEqns();
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),
        Math.tex('\\text{Wave propagation: }', textStyle: const TextStyle(fontSize: 18),),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Math.tex('\\vec{a}_{k}= $a_k_Wave_Propagation_2', textStyle: const TextStyle(fontSize: 18),),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            //E_{01}
            Math.tex(E01, textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _E01,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update2CompEqns(),
              ),
            ),
            const SizedBox(width: 10),
            //E_{02}
            Math.tex(E02, textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _E02,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update2CompEqns(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            //H_{01}
            Math.tex(H01, textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _H01,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update2CompEqns(),
              ),
            ),
            const SizedBox(width: 10),
            //H_{02}
            Math.tex(H02, textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _H02,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update2CompEqns(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            //phi1
            Math.tex(phi1, textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _phi1,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update2CompEqns(),
              ),
            ),
            const SizedBox(width: 10),

            //phi2
            Math.tex(phi2, textStyle: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: MathField(
                controller: _phi2,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: OutlineInputBorder(),
                ),
                keyboardType: MathKeyboardType.expression,
                onChanged: (_) => _update2CompEqns(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Math.tex('Polarisation= $polarisation', textStyle: const TextStyle(fontSize: 18),),
        const SizedBox(height: 20),
      ],
    );
  }
}
