import 'package:flutter/material.dart';

import 'package:emwavepro/Lossy/1_Lossy_Conductivity.dart';
import 'package:emwavepro/Lossy/2_Lossy_Permeability.dart';
import 'package:emwavepro/Lossy/3_Lossy_Permittivity.dart';

/// A widget that displays properties of a lossless medium.
class LossyMediumPropertiesWidget extends StatefulWidget {
  @override
  _LossyMediumPropertiesWidgetState createState() => _LossyMediumPropertiesWidgetState();
}

class _LossyMediumPropertiesWidgetState extends State<LossyMediumPropertiesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0), // You can adjust the padding as needed
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lossy_ConductivityDisplayWidget(),
            Lossy_PermeabilityDisplayWidget(),
            Lossy_PermittivityDisplayWidget(),
          ],
        ),
      ),
    );
  }
}

class LossyMediumDropdown extends StatefulWidget {
  @override
  _LossyMediumDropdownState createState() => _LossyMediumDropdownState();
}

class _LossyMediumDropdownState extends State<LossyMediumDropdown> {
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
                const Text("Lossy Medium Properties", style: TextStyle(fontSize: 16,)),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        // Show the widget content if expanded
        if (isExpanded) LossyMediumPropertiesWidget(),
      ],
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: const Text('Lossy Medium Properties')),
//       body: LossyMediumDropdown())));
// }