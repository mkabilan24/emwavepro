import 'package:flutter/material.dart';
import 'package:emwavepro/0_Main_Version/Lossy/Lossy_Medium_Properties.dart';
import 'package:emwavepro/0_Main_Version/Lossy/Lossy_WaveEM_Frequency_Properties.dart';
import 'package:emwavepro/0_Main_Version/Lossy/Lossy_WaveEM_Properties.dart';

Widget main_lossy() {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          LossyMediumDropdown(),
          LossyWaveEMFreqDropdown(),
          LossyWaveEMDropdown(),
          const SizedBox(height: 100),
        ],
      ),
    ),
  );
}