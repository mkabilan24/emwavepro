import 'package:flutter/material.dart';

import 'package:emwavepro/Lossless/2_Lossless_Permeability.dart';
import 'package:emwavepro/Lossless/3_Lossless_Permittivity.dart';
import 'package:emwavepro/Lossless/1_Lossless_Conductivity.dart';
import 'package:emwavepro/Lossless/4_Lossless_IntrinsicImpedance.dart';

/// A widget that displays properties of a lossless medium.
class LosslessMediumPropertiesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0), // You can adjust the padding as needed
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lossless_ConductivityDisplayWidget(),
            Lossless_PermeabilityDisplayWidget(),
            Lossless_PermittivityDisplayWidget(),
            Lossless_IntrinsicImpedanceDisplayWidget(context),
          ],
        ),
      ),
    );
  }
}

class LosslessMediumDropdown extends StatefulWidget {
  @override
  _LosslessMediumDropdownState createState() => _LosslessMediumDropdownState();
}

class _LosslessMediumDropdownState extends State<LosslessMediumDropdown> {
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
                const Text("Lossless Medium Properties", style: TextStyle(fontSize: 16,)),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) LosslessMediumPropertiesWidget(),
      ],
    );
  }
}