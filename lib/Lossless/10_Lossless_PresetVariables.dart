import 'package:emwavepro/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/Lossless/2_Lossless_Permeability.dart';
import 'package:emwavepro/Lossless/3_Lossless_Permittivity.dart';
import 'package:emwavepro/Lossless/4_Lossless_IntrinsicImpedance.dart';
import 'package:emwavepro/Lossless/5_Lossless_Frequencies.dart';
import 'package:emwavepro/Lossless/7_Lossless_WaveNumber.dart';
import 'package:emwavepro/Lossless/8_Lossless_PhaseConstant.dart';
import 'package:emwavepro/Lossless/9_Lossless_Equations_Components.dart';
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
                print('Linear');
                setState(() {
                  updateDouble(lossless_relativepermeability, 1);
                  calc_lossless_permeability();
                  updateDouble(lossless_relativepermittivity, 1);
                  calc_lossless_permittivity();
                  calc_lossless_intrinsicimpedance();

                  updateDouble(freq, 10000000);
                  calc_angular_freq();
                  calc_lossless_wavenumber();
                  calc_lossless_phaseconstant();

                  numofcomponents = 1;

                  updateDouble(electricabsoluteE1, 10);
                  calc_lossless_H(electricabsoluteE1, magneticabsoluteH1, 1);
                  updateDouble(phaseangle1, 0);

                  electricabsoluteE2.clear();
                  magneticabsoluteH2.clear();
                  phaseangle2.clear();
                });
              },
              child: Text('Linear'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Elliptical');
                setState(() {
                  setState(() {
                    updateDouble(lossless_relativepermeability, 1);
                    calc_lossless_permeability();
                    updateDouble(lossless_relativepermittivity, 1);
                    calc_lossless_permittivity();
                    calc_lossless_intrinsicimpedance();

                    updateDouble(freq, 10000000);
                    calc_angular_freq();
                    calc_lossless_wavenumber();
                    calc_lossless_phaseconstant();

                    numofcomponents = 2;

                    updateDouble(electricabsoluteE1, 10);
                    calc_lossless_H(electricabsoluteE1, magneticabsoluteH1, 1);
                    updateDouble(phaseangle1, 0);

                    updateDouble(electricabsoluteE2, 10);
                    calc_lossless_H(electricabsoluteE2, magneticabsoluteH2, 2);
                    updateDouble(phaseangle2, 30);
                  });
                });
              },
              child: Text('Elliptical'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Circular');
                setState(() {
                  setState(() {
                    updateDouble(lossless_relativepermeability, 1);
                    calc_lossless_permeability();
                    updateDouble(lossless_relativepermittivity, 1);
                    calc_lossless_permittivity();
                    calc_lossless_intrinsicimpedance();

                    updateDouble(freq, 10000000);
                    calc_angular_freq();
                    calc_lossless_wavenumber();
                    calc_lossless_phaseconstant();

                    numofcomponents = 2;

                    updateDouble(electricabsoluteE1, 10);
                    calc_lossless_H(electricabsoluteE1, magneticabsoluteH1, 1);
                    updateDouble(phaseangle1, 0);

                    updateDouble(electricabsoluteE2, 10);
                    calc_lossless_H(electricabsoluteE2, magneticabsoluteH2, 2);
                    updateDouble(phaseangle2, 90);
                  });
                });
              },
              child: Text('Circular'),
            ),
          ],
        );
  }
}
