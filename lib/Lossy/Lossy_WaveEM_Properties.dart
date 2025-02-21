import 'package:flutter/material.dart';

import 'package:emwavepro/Lossy/6_Lossy_Complex_Permittivity.dart';
import 'package:emwavepro/Lossy/7_Lossy_IntrinsicImpedance.dart';
import 'package:emwavepro/Lossy/14_Lossy_WaveNumber.dart';
import 'package:emwavepro/Lossy/8_Lossy_PropagationConstant.dart';
import 'package:emwavepro/Lossy/9_Lossy_AttenuationConstant.dart';
import 'package:emwavepro/Lossy/10_Lossy_PhaseConstant.dart';
import 'package:emwavepro/Lossy/11_Lossy_PhaseVelocity.dart';
import 'package:emwavepro/Lossy/12_Lossy_Wavelength.dart';
import 'package:emwavepro/Lossy/13_Lossy_SkinDepth.dart';
import 'package:emwavepro/Lossy/5_LossTangent.dart';

/// A widget that displays properties of a lossless medium.
class LossyWaveEMPropertiesWidget extends StatefulWidget {
  @override
  _LossyWaveEMPropertiesWidgetState createState() =>
      _LossyWaveEMPropertiesWidgetState();
}

class _LossyWaveEMPropertiesWidgetState
    extends State<LossyWaveEMPropertiesWidget> {
  @override
  void initState() {
    super.initState();
    calc_losstangent();
  }

  void _updateComplexEquations() {
    setState(() {
      print('Complex equations Displayed');
      calc_losstangent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(0.0), // You can adjust the padding as needed
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lossy_LosstangentDisplayWidget(),
                  Lossy_Complex_PermittivityDisplayWidget(),
                  Lossy_Complex_IntrinsicImpedanceDisplayWidget(),
                  Lossy_WaveNumberDisplayWidget(),
                  Lossy_PropagationConstantDisplayWidget(),
                  Lossy_AttenuationConstantDisplayWidget(),
                  Lossy_PhaseConstantDisplayWidget(),
                  Lossy_PhaseVelocityDisplayWidget(),
                  Lossy_WavelengthDisplayWidget(),
                  Lossy_SkindepthDisplayWidget(),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _updateComplexEquations,
              child: const Text('Update'),
            ),
          ],
        ));
  }
}

class LossyWaveEMDropdown extends StatefulWidget {
  @override
  _LossyWaveEMDropdownState createState() => _LossyWaveEMDropdownState();
}

class _LossyWaveEMDropdownState extends State<LossyWaveEMDropdown> {
  bool isExpanded = false; // Controls visibility of widget content

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded; // Toggle expansion
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("EM Wave Properties in Lossy Medium",
                    style: TextStyle(
                      fontSize: 16,
                    )),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) LossyWaveEMPropertiesWidget(),
      ],
    );
  }
}
