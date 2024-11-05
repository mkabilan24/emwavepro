import 'package:emwavepro/0_Main_Version/zfirst_comp_graphic_test.dart';
import 'package:flutter/material.dart';

import 'package:emwavepro/0_Main_Version/Lossless/2_Lossless_Permeability.dart';
import 'package:emwavepro/0_Main_Version/Lossless/3_Lossless_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/Lossless/1_Lossless_Conductivity.dart';
import 'package:emwavepro/0_Main_Version/Lossless/4_Lossless_IntrinsicImpedance.dart';
import 'package:emwavepro/0_Main_Version/Lossless/5_Lossless_Frequencies.dart';
import 'package:emwavepro/0_Main_Version/Lossless/6_Lossless_AttenuationConstant.dart';
import 'package:emwavepro/0_Main_Version/Lossless/7_Lossless_PhaseConstant.dart';
import 'package:emwavepro/0_Main_Version/Lossless/8_Lossless_WaveNumber.dart';

import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';


/// A widget that displays properties of a lossless medium.
class LosslessMediumPropertiesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lossless_ConductivityDisplayWidget(),
                Lossless_PermeabilityDisplayWidget(),
                Lossless_PermittivityDisplayWidget(),
                Lossless_IntrinsicImpedanceDisplayWidget(),

                FrequencyDisplayWidget(),
                AngularFrequencyDisplayWidget(),

                Lossless_WaveNumberDisplayWidget(),
                Lossless_AttenuationConstantDisplayWidget(),
                Lossless_PhaseConstantDisplayWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Lossless Medium Properties')),
      body: LosslessMediumPropertiesWidget(),
    ),
  ));
}