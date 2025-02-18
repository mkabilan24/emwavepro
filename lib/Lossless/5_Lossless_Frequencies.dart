import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';

import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';

import 'package:emwavepro/Lossless/7_Lossless_WaveNumber.dart';

void calc_freq() {
  if (angularfreq.isEmpty) {
    freq.clear();
    return;
  }
  double angularfreqValue = getDouble(angularfreq);
  double freqValue = angularfreqValue / (2 * pi);
  updateDouble(freq, freqValue);
  print("The frequency is $freqValue.");
}

void calc_angular_freq() {
  if (freq.isEmpty) {
    angularfreq.clear();
    return;
  }
  double freqValue = getDouble(freq);
  double angularfreqValue = 2 * pi * freqValue;
  updateDouble(angularfreq, angularfreqValue);
  print("The angular frequency is $angularfreqValue.");
}

Widget FrequencyDisplayWidget(context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
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
                onChanged: (value) {
                  if (!onchange) {
                    onchange = true;
                    if (freq.isEmpty) {
                      angularfreq.clear();
                      lossless_wavenumber.clear();
                      lossless_phaseconstant.clear();
                      snackbarController.hideErrorSnackBar();
                    }
                    else if (!inputHandler(freq)) {
                      if (convertMathExpressionToDouble(freq) >= 0) {
                        calc_angular_freq();
                        calc_lossless_wavenumber();
                        snackbarController.hideErrorSnackBar();
                      }
                      else {
                        snackbarController.showPermanentErrorSnackBar(
                            context, "Input Error: Frequency (f) must be positive!");
                      }
                    }
                    else {
                        snackbarController.showPermanentErrorSnackBar(
                            context, "Input Error: Frequency (f)");
                    }
                    onchange = false;
                  }
                },
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

Widget AngularFrequencyDisplayWidget(context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
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
                onChanged: (value) {
                  if (!onchange) {
                    onchange = true;
                    if (angularfreq.isEmpty) {
                      freq.clear();
                      lossless_wavenumber.clear();
                      lossless_phaseconstant.clear();
                      snackbarController.hideErrorSnackBar();
                    }
                    else if (!inputHandler(angularfreq)) {
                      if (convertMathExpressionToDouble(angularfreq) >= 0) {
                        calc_freq();
                        calc_lossless_wavenumber();
                        snackbarController.hideErrorSnackBar();
                      }
                      else {
                        snackbarController.showPermanentErrorSnackBar(
                            context, "Input Error: Angular Frequency (ω) must be positive!");
                      }
                    }
                    else {
                        snackbarController.showPermanentErrorSnackBar(
                            context, "Input Error: Angular Frequency (ω)");
                    }
                    onchange = false;
                  }
                },
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