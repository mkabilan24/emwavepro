import 'dart:math';

import 'package:emwavepro/Lossy/0_Lossy_GlobalVariables.dart';
import 'package:emwavepro/Lossy/11_Lossy_PhaseVelocity.dart';
import 'package:emwavepro/Lossy/12_Lossy_Wavelength.dart';
import 'package:emwavepro/Lossy/13_Lossy_SkinDepth.dart';
import 'package:emwavepro/Lossy/14_Lossy_WaveNumber.dart';
import 'package:emwavepro/Lossy/2_Lossy_Permeability.dart';
import 'package:emwavepro/Lossy/3_Lossy_Permittivity.dart';
import 'package:emwavepro/Lossy/4_Lossy_Frequencies.dart';
import 'package:emwavepro/Lossy/5_LossTangent.dart';
import 'package:emwavepro/Lossy/6_Lossy_Complex_Permittivity.dart';
import 'package:emwavepro/Lossy/7_Lossy_IntrinsicImpedance.dart';
import 'package:emwavepro/Lossy/8_Lossy_PropagationConstant.dart';
import 'package:emwavepro/Lossy/9_Lossy_AttenuationConstant.dart';
import 'package:emwavepro/Shared/MathFieldEditingFunctions.dart';
import 'package:flutter/material.dart';

class PresetButtonRowWidget extends StatefulWidget {
  @override
  _PresetButtonRowWidgetState createState() => _PresetButtonRowWidgetState();
}

class _PresetButtonRowWidgetState extends State<PresetButtonRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            print('Random');
            setState(() {
              updateDouble(lossy_conductivity, (Random().nextInt(9)+1) / (Random().nextInt(9)+1));
              updateDouble(lossy_relativepermeability, (Random().nextInt(9)+1) / (Random().nextInt(9)+1));
              calc_lossy_permeability();
              updateDouble(lossy_relativepermittivity, (Random().nextInt(9)+1) / (Random().nextInt(9)+1));
              calc_lossy_permittivity();
              updateDouble(freq, ((Random().nextInt(9)+1) / (Random().nextInt(9)+1))*pow(10, (Random().nextInt(9)+1) / (Random().nextInt(9)+1)));
              calc_angular_freq();
              updateDouble(electricabsoluteE1, (Random().nextInt(99)+1) / (Random().nextInt(99)+1));
              updateDouble(phaseangleE1, (Random().nextInt(90)) / (Random().nextInt(90)));

              calc_losstangent();
              calc_complex_permittivity();
              calc_complex_impedance();
              calc_wave_number_roots();
              calc_propagation_constant();
              calc_lossy_attenuationconstant();
              calc_lossy_phasevelocity();
              calc_wavelength();
              calc_skindepth();
            });
          },
          child: Text('Random'),
        )
      ],
    );
  }
}
