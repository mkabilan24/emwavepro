// import 'package:flutter/material.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:math_keyboard/math_keyboard.dart';

// import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';

// void calc_lossless_H0() {
//   if (lossless_intrinsicimpedance.isEmpty || electricabsoluteE0.isEmpty) {
//     magneticabsoluteH0.clear();
//     return;
//   }
//   double intrinsicimpedanceValue = convertMathExpressionToDouble(lossless_intrinsicimpedance);
//   double electricabsoluteE0Value = convertMathExpressionToDouble(electricabsoluteE0);
//   double magneticabsoluteH0Value = electricabsoluteE0Value / intrinsicimpedanceValue;
//   updateDouble(magneticabsoluteH0, magneticabsoluteH0Value);
//   print("|H_0| = $magneticabsoluteH0Value.");
// }

// Widget E0DisplayWidget() {
//   return Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(children: [
//       Math.tex(
//         "\\text{Amplitude of E-Field, E₀ = }",
//         textStyle: const TextStyle(fontSize: 18),
//       ),
//       const SizedBox(width: 10),
//       Container(
//         width: 100, // Set the fixed width
//         height: 40, // Set the fixed height
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey), // Add border if needed
//         ),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               minWidth: 100, // Ensure minimum width matches container width
//             ),
//             child: IntrinsicWidth(
//               child: MathField(
//                 controller: electricabsoluteE0,
//                 decoration: const InputDecoration(
//                   hintText: "Input",
//                   border: InputBorder.none, // Remove the border
//                 ),
//                 keyboardType: MathKeyboardType.expression,
//                 onChanged: (value) {
//                   if (!onchange) {
//                     onchange = true;
//                     calc_lossless_H0();
//                     onchange = false;
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//       Math.tex(
//         '\\text{ V/m}',
//         textStyle: const TextStyle(fontSize: 18),
//       )
//     ]),
//   );
// }