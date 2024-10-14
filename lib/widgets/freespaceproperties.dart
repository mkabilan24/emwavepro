import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class FreespacePropertiesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    ExpansionTile(title: const Text("FreeSpace Properties", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Math.tex('\\text{Permeability, }\\mu = \\mu_0 = 4\\pi*10^{-7}\\,H/m', textStyle: const TextStyle(fontSize: 18)),
        const SizedBox(height: 15),
        Math.tex('\\text{Permittivity, }\\varepsilon = \\varepsilon_0 = \\frac{1}{36\\pi}*10^{-9}\\,F/m', textStyle: const TextStyle(fontSize: 18)),
        const SizedBox(height: 15),
        Math.tex('\\text{Conductivity, }\\sigma = 0\\,S/m', textStyle: const TextStyle(fontSize: 18)),
        const SizedBox(height: 15),
        Math.tex('\\text{Intrinsic impedance, }\\eta = \\sqrt{\\frac{\\mu}{\\varepsilon}} = \\frac{E}{H} = 120\\pi \\approx 377\\,\\Omega', textStyle: const TextStyle(fontSize: 18)),
        const SizedBox(height: 15),
      ],
    );
  }
}