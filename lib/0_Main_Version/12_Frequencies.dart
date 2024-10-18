import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/1_MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/2_LaTexExpressionFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

void calc_freq() {
  double angularfreqValue = getDouble(angularfreq);
  double freqValue = angularfreqValue / (2 * pi);
  updateDouble(freq, freqValue);
  print("The frequency is $freqValue.");
}

void calc_angular_freq() {
  double freqValue = getDouble(freq);
  double angularfreqValue = 2 * pi * freqValue;
  updateDouble(angularfreq, angularfreqValue);
  print("The angular frequency is $angularfreqValue.");
}

Widget FrequencyDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(children: [
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
                controller: freq,
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
      const SizedBox(width: 10),
      Math.tex(
        'Hz',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}

Widget AngularFrequencyDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(children: [
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
                controller: angularfreq,
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
      const SizedBox(width: 10),
      Math.tex(
        'rad/s',
        textStyle: const TextStyle(fontSize: 18),
      ),
    ]),
  );
}