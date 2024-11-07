
import 'package:emwavepro/0_Main_Version/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

Widget Lossy_ConductivityDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(children: [
      Math.tex(
        '\\text{Conductivity, }\\sigma = 0',
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
                controller: lossy_conductivity,
                decoration: const InputDecoration(
                  hintText: "Input",
                  border: InputBorder.none, // Remove the border
                ),
                keyboardType: MathKeyboardType.expression,
              ),
            ),
          ),
        ),
      ),
      Math.tex(
        '\\text{ S/m}',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}