//Main
import 'package:emwavepro/0_Main_Version/0_GlobalVariables.dart';
import 'package:emwavepro/0_Main_Version/12_Frequencies.dart';
import 'package:emwavepro/0_Main_Version/16_Conductivity.dart';
import 'package:emwavepro/0_Main_Version/3_Permeability.dart';
import 'package:emwavepro/0_Main_Version/4_Permittivity.dart';
import 'package:emwavepro/0_Main_Version/5_IntrinsicImpedance.dart';
import 'package:emwavepro/0_Main_Version/13_WaveNumber.dart';
import 'package:emwavepro/0_Main_Version/7_AttenuationConstant.dart';
import 'package:emwavepro/0_Main_Version/8_PhaseConstant.dart';
import 'package:emwavepro/0_Main_Version/17_FreeSpaceProperties.dart';
import 'package:emwavepro/widgets/losslessmediumproperties.dart';
import 'package:emwavepro/widgets/lossymediumproperties.dart';
import 'package:flutter/material.dart';

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

enum Options { option1, option2, option3 }

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  Options _selectedOption = Options.option1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
      Column(
        children: [
          Row(
            children: [
              Radio<Options>(
                value: Options.option1,
                groupValue: _selectedOption,
                onChanged: (Options? value) {
                  setState(() {
                    set_freespace_properties(); //Another exception was thrown: ScrollController not attached to any scroll views.
                    _selectedOption = value!;
                  });
                },
              ),
              const Text('FreeSpace'),
              Radio<Options>(
                value: Options.option2,
                groupValue: _selectedOption,
                onChanged: (Options? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
              const Text('Lossless'),
              Radio<Options>(
                value: Options.option3,
                groupValue: _selectedOption,
                onChanged: (Options? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
              const Text('Lossy'),
            ],
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedOption == Options.option1) ...[
                  //FreeSpace
                  FreeSpacePropertiesDisplayWidget(),
                ],
                if (_selectedOption == Options.option2) ...[
                  //Lossless
                  const Text("Lossless Medium Properties"),
                  //LosslessMediumPropertiesWidget(),
                ],
                if (_selectedOption == Options.option3) ...[
                  //Lossy
                  const Text("Lossy Medium Properties"),
                  //LossyMediumPropertiesWidget(),
                ],
              ],
            ),
          ),
        ],
      )
    );
  }
}