import 'dart:math';
import 'package:emwavepro/0_Main_Version/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Lossy/13_Lossy_SkinDepth.dart';
import 'package:emwavepro/0_Main_Version/Shared/LaTexExpressionFormatter.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

//Lossy
//Not in use
void calc_lossy_attenuationconstant() {
  double freqValue = getDouble(freq);
  double permeabilityValue = getDouble(lossy_permeability);
  double conductivityValue = getDouble(lossy_conductivity);
  double attenuationconstantValue = sqrt(pi * freqValue * permeabilityValue * conductivityValue);
  updateDouble(lossy_attenuationconstant, attenuationconstantValue);
  print("The calculated Attenuation Constant is $attenuationconstantValue.");
}

void set_lossy_attenuationconstant() {
  if (lossy_attenuationconstant.isEmpty) {
    return;
  }
  //notifier
  double attenuationconstantValue = getDouble(lossy_attenuationconstant);
  calc_skindepth();
  print("The Attenuation Constant is $attenuationconstantValue.");
}

Widget Lossy_AttenuationConstantDisplayWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child:
      Row(children: [
        Math.tex('\\text{Attenuation Constant, } \\alpha = ${(lossy_attenuationconstant.isEmpty) ? 0 : displayexpression(lossy_attenuationconstant)} \\:Np/m \\:\\neq\\:0', textStyle: const TextStyle(fontSize: 18),),
      ]),
    );
}

// Widget Lossy_AttenuationConstantDisplayWidget() {
//   return Padding(
//     padding: const EdgeInsets.all(5.0),
//     child: Row(children: [
//       Math.tex(
//         '\\text{Conductivity, }\\sigma \\neq 0 = ',
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
//                 controller: lossy_attenuationconstant,
//                 decoration: const InputDecoration(
//                   hintText: "Input",
//                   border: InputBorder.none, // Remove the border
//                 ),
//                 keyboardType: MathKeyboardType.expression,
//                 onChanged: (value) {
                  
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//       Math.tex(
//         '\\text{ S/m}',
//         textStyle: const TextStyle(fontSize: 18),
//       ),
//     ]),
//   );
// }
