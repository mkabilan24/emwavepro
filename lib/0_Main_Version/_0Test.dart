//Main
import 'package:emwavepro/0_Main_Version/Lossless/0_Lossless_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/Lossless/5_Lossless_Frequencies.dart';
import 'package:emwavepro/0_Main_Version/Lossless/1_Lossless_Conductivity.dart';
import 'package:emwavepro/0_Main_Version/Shared/MathFieldEditingFunctions.dart';
import 'package:emwavepro/0_Main_Version/Lossless/2_Lossless_Permeability.dart';
import 'package:emwavepro/0_Main_Version/Lossless/3_Lossless_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/Lossless/4_Lossless_IntrinsicImpedance.dart';
import 'package:emwavepro/0_Main_Version/Lossless/8_Lossless_WaveNumber.dart';
import 'package:emwavepro/0_Main_Version/Lossless/6_Lossless_AttenuationConstant.dart';
import 'package:emwavepro/0_Main_Version/Lossless/7_Lossless_PhaseConstant.dart';
import 'package:emwavepro/0_Main_Version/17_FreeSpaceProperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_keyboard/math_keyboard.dart';

void main() {
  runApp(MaterialApp(
    home: MainWidget(),
  ));
}


Widget LosslessMediumPropertiesWidget () {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Lossless_ConductivityDisplayWidget(),
      PermeabilityDisplayWidget(),
      PermittivityDisplayWidget(),
      IntrinsicImpedanceDisplayWidget(),
      FrequencyDisplayWidget(),
      AngularFrequencyDisplayWidget(),
      WaveNumberDisplayWidget(),
      Lossless_AttenuationConstantDisplayWidget(),
      Lossless_PhaseConstantDisplayWidget(),
    ],
  );
}

Widget LossyMediumPropertiesWidget () {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Lossy_ConductivityDisplayWidget(),
      PermeabilityDisplayWidget(),
      PermittivityDisplayWidget(),
      IntrinsicImpedanceDisplayWidget(),
      FrequencyDisplayWidget(),
      AngularFrequencyDisplayWidget(),
      WaveNumberDisplayWidget(),
    ],
  );
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Widget'),
      ),
      body: LosslessMediumPropertiesWidget(),
    );
  }
}