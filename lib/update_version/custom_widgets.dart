import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';


class MathFieldWithHint extends StatelessWidget {
  final MathFieldEditingController controller;
  final String hintText;
  final VoidCallback onChanged;

  MathFieldWithHint({
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (controller.isEmpty)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                color: Colors.white.withOpacity(0.7),
                child: Math.tex(
                  hintText,
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        MathField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardType: MathKeyboardType.expression,
          onChanged: (_) => onChanged(),
        ),
      ],
    );
  }
}
