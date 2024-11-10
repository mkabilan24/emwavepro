import 'package:flutter/material.dart';

import 'package:emwavepro/Lossy/4_Lossy_Frequencies.dart';

/// A widget that displays properties of a lossless medium.
class LossyWaveEMFreqPropertiesWidget extends StatefulWidget {
  @override
  _LossyWaveEMFreqPropertiesWidgetState createState() => _LossyWaveEMFreqPropertiesWidgetState();
}

class _LossyWaveEMFreqPropertiesWidgetState extends State<LossyWaveEMFreqPropertiesWidget> {
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
          ],
        ),
      ),
    );
  }
}

class LossyWaveEMFreqDropdown extends StatefulWidget {
  @override
  _LossyWaveEMFreqDropdownState createState() => _LossyWaveEMFreqDropdownState();
}

class _LossyWaveEMFreqDropdownState extends State<LossyWaveEMFreqDropdown> {
  bool isExpanded = false; // Controls visibility of widget content

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
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
                const Text("EM Wave Frequency in Lossy Medium"),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) LossyWaveEMFreqPropertiesWidget(),
      ],
    );
  }
}