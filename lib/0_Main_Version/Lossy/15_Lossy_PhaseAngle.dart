// import 'package:flutter/material.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:math_keyboard/math_keyboard.dart';


// Widget PhaseAngleDisplayWidget() {
//   return Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(children: [
//       Math.tex(
//         "\\text{Phase angle, φ =}",
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
//                 controller: phaseangle,
//                 decoration: const InputDecoration(
//                   hintText: "Input",
//                   border: InputBorder.none, // Remove the border
//                 ),
//                 keyboardType: MathKeyboardType.expression,
//               ),
//             ),
//           ),
//         ),
//       ),
//       Math.tex(
//         '\\text{ degrees}',
//         textStyle: const TextStyle(fontSize: 18),
//       )
//     ]),
//   );
// }