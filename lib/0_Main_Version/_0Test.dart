//Main
import 'package:emwavepro/0_Main_Version/3_Permeability.dart';
import 'package:emwavepro/0_Main_Version/3_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/4_IntrinsicImpedance.dart';
import 'package:emwavepro/widgets/freespaceproperties.dart';
import 'package:emwavepro/widgets/losslessmediumproperties.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MainWidget(),
  ));
}

class MainWidget extends StatelessWidget {
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
                    child: PermeabilityWidget(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PermittivityWidget(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IntrinsicImpedanceWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}