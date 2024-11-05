import 'package:emwavepro/0_Main_Version/Lossless/10_Lossless_H0.dart';
import 'package:emwavepro/0_Main_Version/Lossless/11_Lossless_PhaseConstant.dart';
import 'package:flutter/material.dart';

import 'package:emwavepro/0_Main_Version/Lossless/5_Lossless_Frequencies.dart';
import 'package:emwavepro/0_Main_Version/Lossless/6_Lossless_AttenuationConstant.dart';
import 'package:emwavepro/0_Main_Version/Lossless/7_Lossless_PhaseConstant.dart';
import 'package:emwavepro/0_Main_Version/Lossless/8_Lossless_WaveNumber.dart';
import 'package:emwavepro/0_Main_Version/Lossless/9_Lossless_E0.dart';

/// A widget that displays properties of a lossless medium.
class LosslessWaveEMPropertiesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0), // You can adjust the padding as needed
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FrequencyDisplayWidget(),
            AngularFrequencyDisplayWidget(),
            Lossless_WaveNumberDisplayWidget(),
            Lossless_AttenuationConstantDisplayWidget(),
            Lossless_PhaseConstantDisplayWidget(),
            E0DisplayWidget(),
            H0DisplayWidget(),
            PhaseAngleDisplayWidget(),
          ],
        ),
      ),
    );
  }
}

class LosslessWaveEMDropdown extends StatefulWidget {
  @override
  _LosslessWaveEMDropdownState createState() => _LosslessWaveEMDropdownState();
}

class _LosslessWaveEMDropdownState extends State<LosslessWaveEMDropdown> {
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
                const Text("EM Wave Properties in Lossless Medium"),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) LosslessWaveEMPropertiesWidget(),
      ],
    );
  }
}