//Main
import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/12_Frequencies.dart';
import 'package:emwavepro/0_Main_Version/3_Permeability.dart';
import 'package:emwavepro/0_Main_Version/3_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/4_IntrinsicImpedance.dart';
import 'package:emwavepro/0_Main_Version/5_WaveNumber.dart';
import 'package:emwavepro/widgets/freespaceproperties.dart';
import 'package:emwavepro/widgets/losslessmediumproperties.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MainWidget(),
  ));
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {

  void updateState() {
    setState(() {
      calc_permittivity();
      calc_permeability();
      calc_intrinsicimpedance();
      calc_angular_freq();
      calc_wavenumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FreespacePropertiesWidget(),
          LosslessMediumPropertiesWidget(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PermeabilityDisplayWidget(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PermittivityDisplayWidget(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IntrinsicImpedanceDisplayWidget(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FrequencyDisplayWidget(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AngularFrequencyDisplayWidget(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: WaveNumberDisplayWidget(),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(onPressed: updateState, child: const Text('Update')),
        ],
      ),
    );
  }
}