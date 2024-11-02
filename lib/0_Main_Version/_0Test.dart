//Main
import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/12_Frequencies.dart';
import 'package:emwavepro/0_Main_Version/3_Permeability.dart';
import 'package:emwavepro/0_Main_Version/4_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/5_IntrinsicImpedance.dart';
import 'package:emwavepro/0_Main_Version/13_WaveNumber.dart';
import 'package:emwavepro/widgets/freespaceproperties.dart';
import 'package:emwavepro/widgets/losslessmediumproperties.dart';
import 'package:emwavepro/widgets/lossymediumproperties.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FreespacePropertiesWidget(),
            LosslessMediumPropertiesWidget(),
            LossyMediumPropertiesWidget(),
            const SizedBox(height: 15),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    scrollDirection: Axis.horizontal,
                    child: Column(
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
                        // Add more widgets here if needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
