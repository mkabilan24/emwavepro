// class PermeabilityWidget extends StatefulWidget {
//   @override
//   _PermeabilityWidgetState createState() => _PermeabilityWidgetState();
// }

// class _PermeabilityWidgetState extends State<PermeabilityWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(children: [
//         Math.tex(
//           '\\text{Permeability, }\\mu = \\mu_{r}\\mu_{0} = ',
//           textStyle: const TextStyle(fontSize: 18),
//         ),
//         const SizedBox(width: 10),
//         Container(
//           width: 100, // Set the fixed width
//           height: 40, // Set the fixed height
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey), // Add border if needed
//           ),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 minWidth: 100, // Ensure minimum width matches container width
//               ),
//               child: IntrinsicWidth(
//                 child: MathField(
//                     controller: relativepermeability,
//                     decoration: const InputDecoration(
//                       hintText: "Input",
//                       border: InputBorder.none, // Remove the border
//                     ),
//                     keyboardType: MathKeyboardType.expression,
//                     // onChanged: (newvalue) {
//                     //   setState(() {
//                     //     //updatepermeability();
//                     //   }); // Trigger a rebuild to update the UI
//                     // }
//                   ),
//               ),
//             ),
//           ),
//         ),
//         Math.tex(
//           '\\mu_{0} = ',
//           textStyle: const TextStyle(fontSize: 18),
//         ),
//         const SizedBox(width: 10),
//         Math.tex(displayexpression(permeability), textStyle: const TextStyle(fontSize: 18)),
//         const SizedBox(width: 10),
//         Math.tex(' H/m', textStyle: const TextStyle(fontSize: 18),),
//       ]),
//     );
//   }
// }

// class PermittivityWidget extends StatefulWidget {
//   @override
//   _PermittivityWidgetState createState() => _PermittivityWidgetState();
// }

// class _PermittivityWidgetState extends State<PermittivityWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Math.tex(
//             '\\text{Permittivity, }\\varepsilon = \\varepsilon_{r}\\varepsilon_{0} = ',
//             textStyle: const TextStyle(fontSize: 18),
//           ),
//           const SizedBox(width: 10),
//           Container(
//             width: 100, // Set the fixed width
//             height: 40, // Set the fixed height
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey), // Add border if needed
//             ),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   minWidth: 100, // Ensure minimum width matches container width
//                 ),
//                 child: IntrinsicWidth(
//                   child: MathField(
//                       controller: relativepermittivity,
//                       decoration: const InputDecoration(
//                         hintText: "Input",
//                         border: InputBorder.none, // Remove the border
//                       ),
//                       keyboardType: MathKeyboardType.expression,
//                       // onChanged: (newvalue) {
//                       //   setState(() {
//                       //     //updatepermittivity();
//                       //   }); // Trigger a rebuild to update the UI
//                       // }
//                     ),
//                 ),
//               ),
//             ),
//           ),
//           Math.tex('\\varepsilon_{0} = ', textStyle: const TextStyle(fontSize: 18),),
//           const SizedBox(width: 10),
//           Math.tex(displayexpression(permittivity), textStyle: const TextStyle(fontSize: 18)),
//           const SizedBox(width: 10),
//           Math.tex(' F/m', textStyle: const TextStyle(fontSize: 18),),
//         ]),
//       );
//   }
// }

// class IntrinsicImpedanceWidget extends StatefulWidget {
//   @override
//   _IntrinsicImpedanceWidgetState createState() =>
//       _IntrinsicImpedanceWidgetState();
// }

// class _IntrinsicImpedanceWidgetState extends State<IntrinsicImpedanceWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(children: [
//         Math.tex(
//           '\\text{Intrinsic Impedance, }',
//           textStyle: const TextStyle(fontSize: 18),
//         ),
//         const SizedBox(height: 15),
//         Math.tex(
//           '\\eta = \\sqrt{\\frac{\\mu}{\\varepsilon}} = \\sqrt{\\frac{\\mu_{r}}{\\varepsilon_{r}}} \\times 120\\pi = ',
//           textStyle: const TextStyle(fontSize: 18),
//         ),
//         const SizedBox(width: 10),
//         // Container(
//         //   width: 100, // Set the fixed width
//         //   height: 40, // Set the fixed height
//         //   decoration: BoxDecoration(
//         //     border: Border.all(color: Colors.grey), // Add border if needed
//         //   ),
//         //   child: SingleChildScrollView(
//         //     scrollDirection: Axis.horizontal,
//         //     child: ConstrainedBox(
//         //       constraints: const BoxConstraints(
//         //         minWidth: 100, // Ensure minimum width matches container width
//         //       ),
//         //       child: IntrinsicWidth(
//         //         child: MathField(
//         //             controller: intrinsicimpedance,
//         //             decoration: const InputDecoration(
//         //               hintText: "Input",
//         //               border: InputBorder.none, // Remove the border
//         //             ),
//         //             keyboardType: MathKeyboardType.expression,
//         //             onChanged: (newvalue) {
//         //               setState(() {
//         //                 //updateintrinsicimpedance();
//         //               }); // Trigger a rebuild to update the UI
//         //             }),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         Math.tex(displayexpression(intrinsicimpedance), textStyle: const TextStyle(fontSize: 18)),
//       ]),
//     );
//   }
// }

// class FrequenciesWidget extends StatefulWidget {
//   @override
//   _FrequenciesWidgetState createState() => _FrequenciesWidgetState();
// }

// class _FrequenciesWidgetState extends State<FrequenciesWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Math.tex(
//             '\\text{Frequency, }f = ',
//             textStyle: const TextStyle(fontSize: 18),
//           ),
//           const SizedBox(width: 10),
//           Container(
//             width: 100, // Set the fixed width
//             height: 40, // Set the fixed height
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey), // Add border if needed
//             ),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   minWidth: 100, // Ensure minimum width matches container width
//                 ),
//                 child: IntrinsicWidth(
//                   child: MathField(
//                       controller: relativepermittivity,
//                       decoration: const InputDecoration(
//                         hintText: "Input",
//                         border: InputBorder.none, // Remove the border
//                       ),
//                       keyboardType: MathKeyboardType.expression,
//                       // onChanged: (newvalue) {
//                       //   setState(() {
//                       //     //updatepermittivity();
//                       //   }); // Trigger a rebuild to update the UI
//                       // }
//                     ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Math.tex(' Hz', textStyle: const TextStyle(fontSize: 18),),
//         ]),
//       );
//   }
// }